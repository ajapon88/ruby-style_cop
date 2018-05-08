module StyleCop
  class Violation
    include Comparable
    attr_reader :end_column, :end_line, :line_number, :rule, :rule_id, :rule_namespace, :section, :source, :start_column, :start_line, :message

    def initialize(section: nil, line_number: nil, start_line: nil, start_column: nil, end_line: nil, end_column: nil, source: nil, rule_namespace: nil, rule: nil, rule_id: nil, message: nil)
      @section = section
      @line_number = line_number.to_i
      @start_line = start_line.to_i
      @start_column = start_column.to_i
      @end_line = end_line.to_i
      @end_column = end_column.to_i
      @source = source
      @rule_namespace = rule_namespace
      @rule = rule
      @rule_id = rule_id
      @message = message
    end

    def attributes
      {
        'EndColumn' => end_column,
        'EndLine' => end_line,
        'LineNumber' => line_number,
        'Rule' => rule,
        'RuleId' => rule_id,
        'RuleNamespace' => rule_namespace,
        'Section' => section,
        'Source' => source,
        'StartColumn' => start_column,
        'StartLine' => start_line
      }
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

    def <=>(other)
      compare = 0
      compare = source <=> other.source if compare == 0
      compare = line_number <=> other.line_number if compare == 0
      compare = rule_id <=> other.rule_id if compare == 0
      compare = message <=> other.message if compare == 0
      compare
    end
  end
end
