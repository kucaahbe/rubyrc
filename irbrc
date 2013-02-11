require 'irb/completion'
require 'irb/ext/save-history'

module IRB
  class Extension
    @@all=[]
    def initialize gem_name, &block
      @name = gem_name
      @init_block = block
      @@all << self
    end

    def load!
      require @name
      @init_block.call
    rescue LoadError
      puts "WARNING: gem #{@name} wasn't loaded"
    end

    def self.load_all!
      @@all.each { |e| e.load! }
    end
  end

  module ShellHelpers
    class ShOption
      def initialize option
        @option = option
      end
      def -@
        '-'+@option
      end
    end

    def pwd
      Dir.pwd
    end

    def ls *args
      puts `ls --color=always #{args.join(' ')}`
    end

    private

    def l
      @l||=ShOption.new 'l'
    end

    def la
      @la||=ShOption.new 'la'
    end
  end
end

IRB::Extension.new 'bond' do
  Bond.start
  # For users using a pure ruby readline
  #Bond.start :readline => :ruby
end


IRB.conf[:HISTORY_FILE] = if File.readable? 'config/application.rb'
                            "#{Dir.pwd}/.irb-history"
                          else
                            "#{ENV['HOME']}/.irb-history"
                          end
# how many lines to save
IRB.conf[:SAVE_HISTORY] = 1000

self.extend IRB::ShellHelpers
IRB::Extension.load_all!
