require_relative '../app_manager'
require 'yaml'
# use Converter.new.convert for convert by config
class Converter
  def initialize
    config = YAML.load_file('configure.json')
    @convert_from = config['convert_from']
    @convert_to = config['convert_to']
    @bin_path = config['x2t_path']
    @font_path = config['font_path']
    @output_format = config['format']
  end

  # @param [String] path is a path to folder
  def get_file_paths_list(path)
    FileHelper.list_file_in_directory(path)
  end

  # @param [String] folder_name - name for new folder
  def create_folder(folder_name)
    FileHelper.create_folder(folder_name)
    FileHelper.create_folder("#{folder_name}/not_converted")
  end

  # @param [String] input_filename - input filename with format
  def convert_file(input_filename)
    output_filepath = get_output_filepath(input_filename)
    LoggerHelper.print_to_log "Start convert file #{input_filename} to #{output_filepath}"
    command = "\"#{@bin_path}\" \"#{input_filename}\" \"#{output_filepath}\" \"#{@font_path}\""
    LoggerHelper.print_to_log "Run command #{command}"
    time_before = Time.now
    `#{command}`
    time = Time.now - time_before
    check_file_exist(input_filename, output_filepath, time)
    LoggerHelper.print_to_log 'End convert'
    puts '--' * 75
  end

  def check_file_exist(input_filename, output_filepath, time)
    if File.exist?(output_filepath)
      File.open("#{@output_folder}/results.csv", 'a') do |file|
        file.write "#{file_name(input_filename)};#{file_size(input_filename)};#{time};true;\n"
      end
    else
      File.open("#{@output_folder}/results.csv", 'a') do |file|
        file.write "#{file_name(input_filename)};#{file_size(input_filename)};#{time};false;\n"
      end
      FileHelper.copy_file(input_filename, "#{@output_folder}/not_converted")
    end
  end

  def file_name(input_filename)
    File.basename(input_filename)
  end

  def file_size(input_filename)
    FileHelper.file_size(input_filename) / 1000 / 1000.0
  end

  def x2t_exist?
    File.exist?(@bin_path)
  end

  def get_output_filepath(filepath)
    @output_folder + '/' + File.basename(filepath, '.*') + '.' + @output_format
  end

  def check_macros(file)
    # command = "\"#{@bin_path}\" -detectmacro \"#{file}\""
    system "\"#{@bin_path}\" -detectmacro \"#{file}\""
    $CHILD_STATUS.exitstatus != 0
  end

  def convert
    @output_folder = "#{@convert_to}/result_#{@output_format}_by_#{Time.now.strftime('%d-%b-%Y_%H-%M-%S')}"
    create_folder @output_folder
    File.open("#{@output_folder}/results.csv", 'w') { |file| file.write "filename;filesize(kbytes);time(sec);convert_status\n" }
    get_file_paths_list(@convert_from).each do |current_file_to_convert|
      p current_file_to_convert
      if @output_format == ('docm' || 'xlsm' || 'pptm')
        if check_macros(current_file_to_convert)
          p "Skip #{current_file_to_convert} because it has no macros for #{@output_format}"
          next
        end
      end
      convert_file(current_file_to_convert)
    end
    @output_folder
  end
end