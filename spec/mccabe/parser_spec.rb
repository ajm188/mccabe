require 'spec_helper'
require 'mccabe/parser'

RSpec.describe McCabe::Parser do
  describe '::collect_methods' do
    it 'returns 1 for a single method' do
      code = 'def foo; end'
      ast = McCabe::Parser.parse code
      expect(McCabe::Parser.collect_methods(ast).length).to be 1
    end

    context 'for methods defined in a class' do
      let(:code) do
        <<-CODE
        class MyClass
          def foo
          end

          def bar
          end
        end
        CODE
      end
      let(:ast) { McCabe::Parser.parse code }

      it 'returns the correct number of ASTs' do
        expect(McCabe::Parser.collect_methods(ast).length).to be 2
      end

      it 'returns an AST of each method body' do
        foo_ast = McCabe::Parser.parse 'def foo; end'
        bar_ast = McCabe::Parser.parse 'def bar; end'
        expected = [foo_ast, bar_ast].map { |n| n.children.last }
        result = McCabe::Parser.collect_methods(ast).map { |r| [r].to_h[:body] }
        expect(result).to eq expected
      end
    end
  end
end
