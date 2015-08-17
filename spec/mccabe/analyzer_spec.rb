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
  end
end
