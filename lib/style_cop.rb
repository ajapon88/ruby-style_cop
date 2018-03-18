require 'style_cop/version'
require 'style_cop/violation'
require 'rexml/document'
require 'tempfile'

module StyleCop
  def self.stylecop(setting: nil, flags: [], file: nil, project: nil, solution: nil)
    args = []
    args.push("-set '#{setting}'") unless setting.nil?
    args.push("-flags '#{flags.join(',')}'") unless flags
    args.push("-cs '#{file}'") unless file.nil?
    args.push("-proj '#{project}'") unless project.nil?
    args.push("-sln '#{solution}'") unless solution.nil?
    command = "StyleCopCLI #{args.join(' ')}"
    Tempfile.create do |f|
      ret = `#{command} -out #{f.path}`
      status = $?
      raise ret unless status.success? || status.exitstatus == 2
      doc = REXML::Document.new(open(f.path))
      violations = []
      doc.elements.each('StyleCopViolations/Violation') do |violation|
        attributes = violation.attributes
        violations.push(Violation.new(end_column: attributes['EndColumn'],
                                      end_line: attributes['EndLine'],
                                      line_number: attributes['LineNumber'],
                                      rule: attributes['Rule'],
                                      rule_id: attributes['RuleId'],
                                      rule_namespace: attributes['RuleNameSpace'],
                                      section: attributes['Section'],
                                      source: attributes['Source'],
                                      start_column: attributes['StartColumn'],
                                      start_line: attributes['StartLine'],
                                      message: violation.text))
      end
      violations
    end
  end
end
