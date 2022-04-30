require 'pry'
require_relative './laboratory_test_result'

class Parser
  def initialize(file_path)
    data = File.read(file_path).gsub("\n", "")
    @lab_tests_list = scan_tests(data)
  end

  def mapped_results
    mapped_results = []
    @lab_tests_list.map do |lab_test|
      result = scan_result(lab_test.shift)
      comment = scan_comment(lab_test)
      LaboratoryTestResult.new(code: result[:code], result: result[:result], format: result[:format], comment: comment)
    end
  end

  private

  def scan_tests(data)
    lab_tests_list = data.split("OBX|")&.reject(&:empty?)
    return lab_tests_list.map{|e| e.split("NTE|")}
  end

  def scan_result(test_string)
    test = test_string.split("|")
    code = test[1]
    format = type_format(test[1])
    result =  convert_value(test[2], format.to_sym)
    return { format: format, code: code, result: result} unless code.empty? && result.empty?
  end

  def convert_value(value, format)
    case(format)
    when :float
        value.to_f
    when :boolean
        value == 'NEGATIVE' ? -1.0 : -2.0
    when :nil_3plus
        return -1.0 if value == 'NIL'
        return -2.0 if value == '+' || value == "++"
        return -3.0
    else
        raise StandardError
    end
  end

  def type_format(code)
    if %w[C100 C200].include?(code)
      'float'
    elsif code == 'A250'
      'boolean'
    elsif code == 'B250'
      'nil_3plus'
    end
  end

  def scan_comment(comments_list)
    comments_list.map{|cmt| cmt.split("|").last}.join("\n")
  end
end