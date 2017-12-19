require_relative 'lib/app_manager'
desc 'convert files from custom configure.json'
# rake convert
task :convert do |_t|
  Converter.new.convert
end