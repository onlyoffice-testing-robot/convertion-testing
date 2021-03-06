# frozen_string_literal: true

require 'rspec'
palladium = PalladiumHelper.new(x2t.version, 'Ppt to Pptx')
result_sets = palladium.get_result_sets(StaticData::POSITIVE_STATUSES)
files = s3.get_files_by_prefix('ppt/')
describe 'Conversion ppt files to pptx' do
  before :each do
    @tmp_dir = FileHelper.create_tmp_dir.first
  end
  (files - result_sets.map { |result_set| "ppt/#{result_set}" }).each do |file|
    it File.basename(file) do
      s3.download_file_by_name(file, @tmp_dir)
      @file_data = x2t.convert("#{@tmp_dir}/#{File.basename(file)}", :pptx)
      expect(File.exist?(@file_data[:tmp_filename])).to be_truthy
      expect(OoxmlParser::Parser.parse(@file_data[:tmp_filename])).to be_with_data unless StaticData::EMPTY_FILES.include?(File.basename(file))
    end
  end

  after :each do |example|
    FileHelper.delete_tmp(@tmp_dir)
    palladium.add_result(example, @file_data)
  end
end
