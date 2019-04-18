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

  def convert(file, format, tmp_dir = StaticData::TMP_DIR)
    tmp_filename = "#{tmp_dir}/#{Time.now.nsec}.#{format}"
    size_before = File.size(file)
    t_start = Time.now
    OnlyofficeLoggerHelper.log "#{@path} \"#{file}\" \"#{tmp_filename}\""
    output = `#{@path} "#{file}" "#{tmp_filename}" "#{@fonts_path}" 2>&1`
    elapsed = Time.now - t_start
    result = { tmp_filename: tmp_filename, elapsed: elapsed, size_before: size_before }
    if File.exist?(tmp_filename)
      result[:size_after] = File.size(tmp_filename)
    end
    result[:x2t_result] = output unless output == ''
    result
  end
end
