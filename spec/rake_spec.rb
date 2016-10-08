require 'spec_helper'
require 'rake'
require_relative '../lib/app_manager'
describe 'rake tests' do
load "#{Dir.pwd}/Rakefile.rb"

  it 'check convert task' do
    result_dir_count = Dir['results/*'].length
    Rake::Task['convert'].invoke(:doc, :docx)
    sleep 1 # wait for file/folder created
    expect(result_dir_count).to eq(Dir['results/*'].length - 1)
  end

  it 'check convert_with_config rake task' do
    result_dir_count = Dir['results/*'].length
    Rake::Task['convert_with_config'].invoke(:doc, :docx, 'configure.json')
    sleep 1 # wait for file/folder created
    expect(result_dir_count).to eq(Dir['results/*'].length - 1)
  end
end