require 'parser/current'

BRANCH_TYPES = [:if, :while, :until, :for,
                :case, :when,
                :and, :or]

# Get all files recursively.
def get_all_files(patterns)
  files = []
  patterns.each do |pattern|
    files |=
      if File.directory? pattern
        sub_patterns =
          (Dir.entries(pattern) - ['.', '..']).map { |sub_pat| "#{pattern}/#{sub_pat}" }
        get_all_files(sub_patterns)
      else
        Dir[pattern]
      end
  end
  files
end

def analyze(filename, ast)
  results = {}
  collect_methods(ast).each do |name, method|
    results[name] = {line: method[:line], complexity: complexity(method[:body])}
  end
  results
end

# Collect all the methods from the AST.
def collect_methods(ast)
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
      nodes += node.children
    end
  end
  methods
end

def complexity(ast)
  nodes, complexity = [ast], 0
  until nodes.empty?
    node = nodes.shift
    complexity += 1 if BRANCH_TYPES.include?(node.type)
    nodes += node.children.select { |child| child.is_a? Parser::AST::Node }
  end
  complexity
end

get_all_files(ARGV).each do |file|
  p analyze(file, Parser::CurrentRuby.parse(File.read(file)))
end
