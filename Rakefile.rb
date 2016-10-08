require_relative 'lib/app_manager'

# rake convertconvert
desc 'convert files from default paths'
task :convert, :format_from, :format_to do |_t, args|
  Converter.new(:convert_from=>'assets/files',:convert_to => 'results',:x2t_path => 'assets/x2t/x2t').convert(args[:format_from] => args[:format_to])
end

desc 'convert files from custom configure.json'
# rake convert[doc,docx,configure_file_path]
task :convert_with_config, :format_from, :format_to, :configure_file do |_t, args|
  Converter.new(:configure=>args[:configure_file]).convert(args[:format_from] => args[:format_to])
end