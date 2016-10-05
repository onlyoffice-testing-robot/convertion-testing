require_relative 'lib/app_manager'
# main task for convertion all files from assets/files to /results. It use /x2t folder and take file bin file
# rake convert[doc,docx]
task :convert, :format_from, :format_to do |t, args|
  Converter.new('assets/files','results','assets/x2t/x2t').convert(args[:format_from] => args[:format_to])
end
