require 'mccabe/parser'

module McCabe
  class Analyzer
    BRANCH_TYPES = [:if, :while, :until, :for, :when, :and, :or]

    def self.analyze(filename, ast)
      results = {}
      McCabe::Parser.collect_methods(ast).each do |name, method|
        results[name] = {line: method[:line], complexity: complexity(method[:body])}
      end
      results
    end

    def self.complexity(ast)
      nodes, complexity = [ast], 0
      until nodes.empty?
        node = nodes.shift
        complexity += 1 if BRANCH_TYPES.include?(node.type)
        nodes += node.children.select { |child| child.is_a? ::Parser::AST::Node }
      end
      complexity
    end
  end
end
