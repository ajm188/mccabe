require 'optparse'

module McCabe
  class CLI
    DEFAULT_OPTIONS = {
      threshold: 4,
      quiet: false
    }

    # Print out the results of a file to the console.
    def self.display_results(file_results)
      file_results.each do |method, info|
        puts "\t#{method} (line #{info[:line]}) had a complexity of #{info[:complexity]}"
      end
    end

    # Get all files recursively.
    def self.get_all_files(patterns)
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
      files.select { |file| file.end_with? '.rb' }
    end

    def parse!(argv)
      option_parser.parse! argv
      DEFAULT_OPTIONS.merge options
    end

    private

    def options
      @options ||= {}
    end

    def option_parser
      @option_parser ||= OptionParser.new do |option_parser|
        option_parser.banner = 'Usage: mccabe.rb file1... [options]'

        option_parser.on '-tTHRESHOLD',
                         '--threshold',
                         "threshold of mccabe's complexity to allow through" do |t|
          options[:threshold] = t.to_i
        end

        option_parser.on '--quiet', "No output to stdout. Exit code only (1 for failure)." do |q|
          options[:quiet] = q
        end

        option_parser.on_tail '-h', '--help', "Display this help message" do
          puts option_parser
          exit 0
        end
      end
    end
  end
end
