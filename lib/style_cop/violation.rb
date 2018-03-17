module StyleCop
  class Violation
    attr_reader :end_column, :end_line, :line_number, :rule, :rule_id, :rule_namespace, :section, :source, :start_column, :start_line, :message

    def initialize(end_column: nil, end_line: nil, line_number: nil, rule: nil, rule_id: nil, rule_namespace: nil, section: nil, source: nil, start_column: nil, start_line: nil, message: nil)
      @end_column = end_column
      @end_line = end_line
      @line_number = line_number
      @rule = rule
      @rule_id = rule_id
      @rule_namespace = rule_namespace
      @section = section
      @source = source
      @start_column = start_column
      @start_line = start_line
      @message = message
    end

    def attributes
      { 'EndColumn' => end_column,
        'EndLine' => end_line,
        'LineNumber' => line_number,
        'Rule' => rule,
        'RuleId' => rule_id,
        'RuleNamespace' => rule_namespace,
        'Section' => section,
        'Source' => source,
        'StartColumn' => start_column,
        'StartLine' => start_line }
    end
  end
end
