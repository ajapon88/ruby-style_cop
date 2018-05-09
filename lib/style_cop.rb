require 'style_cop/version'
require 'style_cop/violation'
require 'rexml/document'
require 'tempfile'

module StyleCop
  def self.stylecop(settings: nil, flags: [], file: nil, project: nil, solution: nil)
    args = []
    settings = './Settings.StyleCop' if settings.nil? && File.exist?('./Settings.StyleCop')
    args.push("-set '#{settings}'") unless settings.nil?
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
        violations.push(Violation.new(section: attributes['Section'],
                                      line_number: attributes['LineNumber'],
                                      start_line: attributes['StartLine'],
                                      start_column: attributes['StartColumn'],
                                      end_line: attributes['EndLine'],
                                      end_column: attributes['EndColumn'],
                                      source: attributes['Source'],
                                      rule_namespace: attributes['RuleNameSpace'],
                                      rule: attributes['Rule'],
                                      rule_id: attributes['RuleId'],
                                      message: violation.text))
      end
      violations
    end
  end
end
