require_relative 'lib/app_manager'

# rake convert[doc,docx]
task :convert, :format_from, :format_to do |_t, args|
  Converter.new(:base_file_folder=>'assets/files',:output_folder => 'results',:bin_path => 'assets/x2t/x2t').convert(args[:format_from] => args[:format_to])
end
