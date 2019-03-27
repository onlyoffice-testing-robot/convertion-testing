class FileHelper
  def self.clear_tmp
    puts 'Clear tmp dir'
    Dir["#{StaticData::TMP_DIR}/*"].each do |filepath|
      File.delete(filepath) if File.exist?(filepath)
    end
  end
end