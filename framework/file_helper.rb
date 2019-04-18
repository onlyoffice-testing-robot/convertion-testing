class FileHelper
  def self.delete_tmp(dir)
    OnlyofficeLoggerHelper.log('Clear tmp dir')
    FileUtils.rm_rf(Dir.glob(dir.to_s))
  end

  def self.create_tmp_dir
    dirname = Time.now.nsec.to_s
    OnlyofficeLoggerHelper.log("Create dir with name #{dirname}")
    FileUtils.makedirs("#{StaticData::TMP_DIR}/#{dirname}")
  end
end
