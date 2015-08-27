module McCabe
  class Analyzer
    class MethodInfo
      attr_reader :complexity

      def initialize(name, complexity, file, line)
        @name = name
        @complexity = complexity
        @file = file
        @line = line
      end

      def to_s
        "#{@name} (#{@file}:#{@line}) #{@complexity}"
      end
    end
  end
end
