require 'spec_helper'

require 'mccabe/analyzer'
require 'mccabe/parser'

RSpec.describe McCabe::Analyzer do
  describe '::complexity' do
    context 'when the AST is straight-line code' do
      it 'returns 0' do
        code = <<-CODE
        a = 1
        b = 1 - a
        a * b
        CODE
        ast = McCabe::Parser.parse code
        expect(McCabe::Analyzer.complexity ast).to be 0
      end
    end

    context 'when the AST contains simple branching' do
      it 'returns the number of brancing points' do
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
    end

    context 'when the AST contains complex branching' do
      it 'returns the number of branching points' do
        code = <<-CODE
        if (a && b) || c
          do_a_thing
        end
        CODE
        ast = McCabe::Parser.parse code
        expect(McCabe::Analyzer.complexity ast).to be 3
      end
    end

    context 'when an Enumerable method is used' do
      context 'with a block' do
        it 'returns 1' do
          code = '[1, 2].each { |e| puts e }'
          ast = McCabe::Parser.parse code
          expect(McCabe::Analyzer.complexity ast).to be 1
        end
      end

      context "with 'symbol#to_proc'" do
        it 'returns 1' do
          code = '[1, 2].map(&:to_s)'
          ast = McCabe::Parser.parse code
          expect(McCabe::Analyzer.complexity ast).to be 1
        end
      end

      context 'without a block' do
        it 'returns 0' do
          code = '[1, 2].map.each.count'
          ast = McCabe::Parser.parse code
          expect(McCabe::Analyzer.complexity ast).to be 0
        end
      end
    end
  end
end
