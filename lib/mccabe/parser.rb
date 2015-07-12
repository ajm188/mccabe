require 'parser/current'

module McCabe
  class Parser < Parser::CurrentRuby
    # Collect all the methods from the AST.
    def self.collect_methods(ast)
      methods = {}
      nodes = [ast]
      until nodes.empty?
        node = nodes.shift
        case node.type
        when :def, :defs
          name = node.children.length == 4 ? node.children[1] : node.children.first
          methods[name] = {body: node.children.last, line: node.loc.line}
        when :class, :module, :begin
          # Have to put node.children in an array and flatten in because the parser
          # returns a frozen array.
          nodes += node.children.select { |child| child.is_a? ::Parser::AST::Node }
        end
      end
      methods
    end
  end
end
