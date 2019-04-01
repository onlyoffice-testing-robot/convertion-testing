class FileHelper
  def self.clear_tmp
    OnlyofficeLoggerHelper.log('Clear tmp dir')
    Dir["#{StaticData::TMP_DIR}/*"].each do |filepath|
      File.delete(filepath) if File.exist?(filepath)
    end
  end
end