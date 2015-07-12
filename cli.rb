require 'optparse'

class CLI
  def parse!(argv)
    option_parser.parse! argv
    options
  end

  private

  def option_parser
    @option_parser ||= OptionParser.new do |option_parser|
      option_parser.banner = 'Usage: mccabe.rb file1... [options]'

      option_parser.on '-tTHRESHOLD',
                       '--threshold',
                       "threshold of mccabe's complexity to allow through" do |t|
        options[:threshold] = t
      end

      option_parser.on '--quiet', "No output to stdout. Exit code only (1 for failure)." do |q|
        option[:quiet] = q
      end

      option_parser.on_tail '-h', '--help', "Display this help message" do
        puts option_parser
        exit 0
      end
    end
  end

  def options
    @options ||= {}
  end
end
