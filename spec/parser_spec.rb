require "./lib/parser.rb"

RSpec.describe Parser do
  let(:test_file_1) { "lab_test_1.txt" }
  let(:test_file_2) { "lab_test_2.txt" }
  let(:parser_1) { Parser.new(test_file_1) }
  let(:parser_2) { Parser.new(test_file_2) }

  context '#mapped_results' do
    it 'Test the first lab test result' do
      parsed_result = parser_1.mapped_results
      expect(parsed_result).to match_array([
        have_attributes(code: 'C100', result: 20.0, format: 'float', comment: "Comment for C100 result"),
      ])
    end

    it 'Test the second lab test result' do
      parsed_result = parser_2.mapped_results
      expect(parsed_result).to match_array([
        have_attributes(code: 'A250', result: -1.0, format: 'boolean', comment: "Comment for NEGATIVE result"),
        have_attributes(code: 'B250', result: -2.0, format: 'nil_3plus', comment: "Comment 1 for ++ result\nComment 2 for ++ result"),
      ])
    end
  end
end
