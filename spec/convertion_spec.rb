require 'spec_helper'
require_relative '../lib/app_manager'
describe 'convertion tests' do

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
end