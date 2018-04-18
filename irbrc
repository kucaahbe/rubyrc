require 'pp'
autoload :Logger, 'logger'
autoload :URI,    'uri'
autoload :Net,    'net/http'
autoload :Base64, 'base64'
autoload :JSON,   'json'
autoload :YAML,   'yaml'

require 'irb/completion'
require 'irb/ext/save-history'

def pp_to_file object, filename
  require 'pp'
  File.open(filename, 'w') { |f| PP.pp(object, f) }
end

history_folder = File.readable?('config/application.rb') ? Dir.pwd : ENV['HOME']
IRB.conf[:HISTORY_FILE] = File.join(history_folder, '.irb-history')
history_folder = nil

# how many lines to save
IRB.conf[:SAVE_HISTORY] = 1000
