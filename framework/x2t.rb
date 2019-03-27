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
end