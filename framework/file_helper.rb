class FileHelper
  def self.clear_tmp
    OnlyofficeLoggerHelper.log('Clear tmp dir')
    FileUtils.rm_rf(Dir.glob('tmp/*'))
  end
end
