require 'mccabe/parser'

module McCabe
  class Analyzer
    BRANCH_TYPES = [:if, :while, :until, :for, :when, :and, :or]
    ENUMERABLE_METHODS = Enumerable.instance_methods + [:each]

    def self.analyze(ast)
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
        if BRANCH_TYPES.include?(node.type)
          complexity += 1
        elsif node.type == :block
          sent_method = node.children[0]
          if sent_method.children.length == 2 &&
              ENUMERABLE_METHODS.include?(sent_method.children[1])
            complexity += 1
          end
        elsif node.type == :send
          if node.children.length >= 3 &&
              node.children[2].type == :block_pass &&
              ENUMERABLE_METHODS.include?(node.children[1])
            complexity += 1
          end
        end
        nodes += node.children.select { |child| child.is_a? ::Parser::AST::Node }
      end
      complexity
    end
  end
end
