require 'erb'

module BackgrounDRbMerb
  class Config
    def self.parse_cmd_options(argv)
      require 'optparse'
      options = { :environment => (Merb.environment || "development").dup }

      OptionParser.new do |opts|
        script_name = File.basename($0)
        opts.banner = "Usage: #{$0} [options]"
        opts.separator ""
        opts.on("-e", "--environment=name", String,
                "Specifies the environment to operate under (test/development/production).",
                "Default: development") { |v| options[:environment] = v }
        opts.separator ""
        opts.on("-h", "--help",
                "Show this help message.") { $stderr.puts opts; exit }
        opts.separator ""
        opts.on("-v","--version",
                "Show version.") { $stderr.puts "1.0.3"; exit }
      end.parse!(argv)
    end

    def self.read_config(config_file)
      config = YAML.load(ERB.new(IO.read(config_file)).result)

      environment = Merb.environment.to_sym
      config[:backgroundrb][:environment] = environment.to_s

      if config[environment]

        # block for deep_merging the hashes
        deep_proc = Proc.new do |key, oldval, newval|
          if oldval.kind_of?(Hash) && newval.kind_of?(Hash)
            next oldval.merge(newval,&deep_proc)
          end
          next newval
        end

        config.merge!( config[environment], &deep_proc)
      end

      config
    end
  end
end