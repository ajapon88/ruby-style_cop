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

    def ==(other)
      return false unless end_column == other.end_column
      return false unless end_line == other.end_line
      return false unless line_number == other.line_number
      return false unless rule == other.rule
      return false unless rule_id == other.rule_id
      return false unless rule_namespace == other.rule_namespace
      return false unless section == other.section
      return false unless source == other.source
      return false unless start_column == other.start_column
      return false unless start_line == other.start_line
      return false unless message == other.message
      true
    end

    def eql?(other)
      self == other
    end

    def hash
      hash = 0
      hash ^= end_column.hash
      hash ^= end_line.hash
      hash ^= line_number.hash
      hash ^= rule.hash
      hash ^= rule_id.hash
      hash ^= rule_namespace.hash
      hash ^= section.hash
      hash ^= source.hash
      hash ^= start_column.hash
      hash ^= start_line.hash
      hash ^= message.hash
      hash
    end
  end
end
