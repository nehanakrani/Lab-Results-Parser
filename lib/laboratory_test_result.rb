
class LaboratoryTestResult
  attr_reader :code, :result, :format, :comment

  def initialize(code:, result:, format:, comment:)
    @code = code
    @format = format
    @comment = comment
    @result = result
  end
end