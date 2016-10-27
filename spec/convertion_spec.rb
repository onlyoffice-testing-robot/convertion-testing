require 'spec_helper'
require_relative '../lib/app_manager'
describe 'convertion tests' do

  before :all do
    File.delete("spec/test_data/test_filelist_2/not_converted/3.txt") if File.exist?("spec/test_data/test_filelist_2/not_converted/3.txt")
  end

  it 'check convert with config' do
    converter = Converter.new(:configure => 'configure.json')
    results_folder = converter.convert(:docx => :rtf)
    results = File.directory?(results_folder)
    expect(results).to be_truthy
  end

  it 'check convert with arguments' do
    converter = Converter.new(:convert_from => "assets/files", :convert_to => "results", :x2t_path => "assets/x2t/x2t", :font_path => "assets/fonts")
    results_folder = converter.convert(:docx => :rtf)
    results = File.directory?(results_folder)
    expect(results).to be_truthy
  end

  it 'check convert one file' do
    converter = Converter.new(:convert_from => "assets/files", :convert_to => "results", :x2t_path => "assets/x2t/x2t", :font_path => "assets/fonts")
    results_folder = converter.convert_one(:input_file => 'assets/files/empty.doc', :format_to => 'docx')
    results = File.exist?(results_folder)
    expect(results).to be_truthy
  end

  it 'check get file diff' do
    converter = Converter.new(:convert_from => "spec/test_data/test_filelist_1", :convert_to => "spec/test_data/test_filelist_2", :x2t_path => "assets/x2t/x2t", :font_path => "assets/fonts")
    filelist1 = FileHelper.list_file_in_directory("spec/test_data/test_filelist_1")
    filelist2 = FileHelper.list_file_in_directory("spec/test_data/test_filelist_2")
    result_file = converter.get_file_difference(filelist1, filelist2)
    results = File.exist?(result_file.first)
    expect(results).to be_truthy
    expect(result_file.first).to eq('spec/test_data/test_filelist_1/3.txt')
  end
end