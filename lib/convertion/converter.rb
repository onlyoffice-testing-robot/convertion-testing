require_relative '../app_manager'

class Converter
  # @param args must contain hash with keys :base_file_folder, :output_folder, and :bin_path
  # Values for this keys - is [String] - path to folder with files for converting (:base_file_folder), path to folder for results (output_folder) and
  # path to x2t file.
  #
  def initialize(*args)
    @base_file_folder = args.first[:base_file_folder]
    @base_output_folder = args.first[:output_folder]
    @bin_path = args.first[:bin_path]
    @base_file_folder.chop! if @base_file_folder.rindex('/') == (@base_file_folder.size - 1)
    @base_output_folder.chop! if @base_output_folder.rindex('/') == (@base_output_folder.size - 1)
  end

  # @param [String] path is a path to folder
  # @param [String] extension find marker. Method will find only files with this word
  def get_file_paths_list(path, extension = nil)
    FileHelper.list_file_in_directory(path, extension)
  end

  # @param [String] folder_name - name for new folder
  def create_folder(folder_name)
    FileHelper.create_folder(folder_name)
    FileHelper.create_folder("#{folder_name}/not_converted")
  end

  # @param [Array] base_file_list - first list of file names
  # @param [Array] last_file_list - second list of file names
  def get_file_difference(base_file_list, last_file_list)
    input_file_names = base_file_list.map { |current_path| File.basename(current_path, '.*') }
    output_file_names = last_file_list.map { |current_path| File.basename(current_path, '.*') }
    not_converted = input_file_names - output_file_names
    File.open("#{@output_folder}/not_converted.txt", 'w') { |i| i.write 'Not converted' }
    not_converted.each do |file|
      LoggerHelper.print_to_log "File Not Converted: #{file}"
      File.open("#{@output_folder}/not_converted.txt", 'a') { |i| i.write file + "\n" }
    end
    not_converted_full_name = not_converted.map { |file_name| `find #{@base_file_folder} -name '#{file_name}.#{@input_format}'`.chomp }
    not_converted_full_name.each do |not_converted_file|
      begin
        FileHelper.copy_file(not_converted_file, "#{@output_folder}/not_converted")
      rescue
        LoggerHelper.print_to_log "#{not_converted_file} not copy"
      end
    end
  end

  # @param [String] input_filename - input filename with format
  # @param [String] output_filename - input filename with format
  def convert_file(input_filename, output_filename)
    LoggerHelper.print_to_log "Start convert file #{input_filename} to #{output_filename}"
    command = "\"#{@bin_path}\" \"#{input_filename}\" \"#{output_filename}\" \"/assets/fonts\""
    LoggerHelper.print_to_log "Run command #{command}"
    a = Time.now
    `#{command}`
    a = Time.now - a
    LoggerHelper.print_to_log 'End convert'
    puts '--' * 75
    File.open("#{@output_folder}/results.csv", 'a') { |file| file.write "#{File.basename(input_filename)};#{FileHelper.file_size(input_filename) / 1000 / 1000.0};#{a};\n" }
  end

  def x2t_exist?
    File.exist?(@bin_path)
  end

  # @param [Hash] option_hash. Key - is a start format, value - result format
  def convert(option_hash)
    raise "x2t file is not found in #{@bin_path} path" unless x2t_exist?
    @input_format = option_hash.keys.first
    @output_format = option_hash.values.first
    @output_folder = "#{@base_output_folder}/#{@input_format}_to_#{@output_format}_by_#{Time.now.strftime('%d_%b_%Y_%H:%M:%S')}"
    create_folder @output_folder
    File.open("#{@output_folder}/results.csv", 'w') { |file| file.write "filename;filesize(kbytes);time(sec)\n" }
    file_list = get_file_paths_list(@base_file_folder, @input_format)
    file_list.each do |current_file_to_convert|
      output_file_path = "#{@output_folder}/#{File.basename(current_file_to_convert, '.*')}.#{@output_format}"
      convert_file(current_file_to_convert, output_file_path)
    end
    get_file_difference(file_list, get_file_paths_list(@output_folder, @output_format))
    @output_folder
  end
end