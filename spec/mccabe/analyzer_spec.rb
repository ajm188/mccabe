require 'spec_helper'

require 'mccabe/analyzer'
require 'mccabe/parser'

RSpec.describe McCabe::Analyzer do
  describe '::complexity' do
    it 'does not count straight-line code' do
      code = <<-CODE
      a = 1
      b = 1 - a
      a * b
      CODE
      ast = McCabe::Parser.parse code
      expect(McCabe::Analyzer.complexity ast).to be 0
    end

    it 'counts the number of branching points' do
      code = <<-CODE
      if foo
        bar
      elsif baz
        qux
      end
      CODE
      ast = McCabe::Parser.parse code
      expect(McCabe::Analyzer.complexity ast).to be 2
    end

    it 'counts complex branches' do
      code = <<-CODE
      if (a && b) || c
        do_a_thing
      end
      CODE
      ast = McCabe::Parser.parse code
      expect(McCabe::Analyzer.complexity ast).to be 3
    end

    context 'when an Enumerable method is used' do
      it 'counts a block as 1' do
        code = '[1, 2].each { |e| puts e }'
        ast = McCabe::Parser.parse code
        expect(McCabe::Analyzer.complexity ast).to be 1
      end

      it 'counts a symbol#to_proc as 1' do
        code = '[1, 2].map(&:to_s)'
        ast = McCabe::Parser.parse code
        expect(McCabe::Analyzer.complexity ast).to be 1
      end

      context 'without a block or symbol#to_proc' do
        it 'returns 0' do
          code = '[1, 2].map.each.count'
          ast = McCabe::Parser.parse code
          expect(McCabe::Analyzer.complexity ast).to be 0
        end
      end
    end

    it 'returns 0 for an empty method' do
      code = <<-CODE
      def foo
      end
      CODE
      ast = McCabe::Parser.parse code
      expect(McCabe::Analyzer.complexity ast).to be 0
    end

    it 'returns 0 on nil' do
      expect(McCabe::Analyzer.complexity nil).to be 0
    end
  end
end
