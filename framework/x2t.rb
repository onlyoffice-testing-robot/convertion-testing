# class for adding ability to use x2t
class X2t
  def initialize(x2t_path = "#{StaticData::PROJECT_BIN_PATH}/x2t")
    @path = x2t_path
    @fonts_path = StaticData::FONTS_PATH
    ENV['LD_LIBRARY_PATH'] = StaticData::PROJECT_BIN_PATH
  end

  def version
    `#{@path}`.match(/Version: (.*)/)[1]
  end

  def run(command)
    `#{@path} ` + command
  end

  def convert(file, format)
    tmp_filename = "#{StaticData::TMP_DIR}/#{Time.now.nsec}.#{format}"
    t_start = Time.now
    OnlyofficeLoggerHelper.log "#{@path} \"#{file}\" \"#{tmp_filename}\""
    output = `#{@path} "#{file}" "#{tmp_filename}" "#{@fonts_path}" 2>&1`
    elapsed = Time.now - t_start
    { tmp_filename: tmp_filename, elapsed: elapsed, x2t_result: output }
  end
end
