# class for adding ability to use x2t
class X2t
  def initialize(x2t_path = "#{StaticData::PROJECT_BIN_PATH}/x2t")
    @path = x2t_path
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
    output = `#{@path} "#{file}" "#{tmp_filename}"`
    elapsed = Time.now - t_start
    { tmp_filename: tmp_filename, elapsed: elapsed, x2t_result: output }
  end
end