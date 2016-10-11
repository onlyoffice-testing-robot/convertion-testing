require_relative 'lib/app_manager'

desc 'convert files from default paths'
# rake convert[doc,docx,configure_file_path]
task :convert_without_config, :format_from, :format_to do |_t, args|
  Converter.new(:convert_from => 'assets/files', :convert_to => 'results', :x2t_path => 'assets/x2t/x2t').convert(args[:format_from] => args[:format_to])
end

task :convert_with_config, :format_from, :format_to, :configure_file do |_t, args|
  Converter.new(:configure=>args[:configure_file]).convert(args[:format_from] => args[:format_to])
end

desc 'convert files from custom configure.json'
# rake convert[doc,docx,configure_file_path]
task :convert, :format_from, :format_to, :configure_file do |_t, args|
  if args[:configure_file].nil?
    Rake::Task['convert_without_config'].invoke(args[:format_from], args[:format_to])
  else
    Rake::Task['convert_with_config'].invoke(args[:format_from], args[:format_to], args[:configure_file])
  end
end

task :convert_all_formats do
  #doc to docx
  result = []
  {:doc=>:docx, :rtf=>:docx, :docx=>:rtf, :odt=>:docx, :docx=>:odt, :xls=>:xlsx, :ods => :xlsx, :xlsx => :ods, :ppt=>:pptx, :odp => :pptx}.each do |current_key, current_value|
    ourput_path = Converter.new(:configure=>'configure.json').convert(current_key => current_value)
    if FileHelper.list_file_in_directory("#{ourput_path}/not_converted").empty?
        FileHelper.delete_directory(ourput_path)
      else
      result << ourput_path
    end
  end
  unless result.empty?
    puts "Not converted:"
    p result
  end
end
