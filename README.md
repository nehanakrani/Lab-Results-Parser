# Lab Results Parser
Implement a solution to read and parse a text file which represents some laboratory test results [Read More here](https://gist.github.com/rodrigofhm/d7b8c38ef966250160ed71ce59a7822c)


# Setup:

- First install dependencies:
    `bundle install`

-  Run the code:
    ```Ruby
    file_path = "/lab1.txt" #assign filename here
    parser = Parser.new('/lab1.txt')
    parser.mapped_results
    # => [ LaboratoryTestResult.new(code: 'C100', result: 20.0, format: 'float', comment: 'Comment for C100 result') ]
    ```
# Tests
- Run the tests:
    `rspec`
