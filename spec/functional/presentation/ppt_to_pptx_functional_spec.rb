require 'rspec'
s3 = OnlyofficeS3Wrapper::AmazonS3Wrapper.new
palladium = PalladiumHelper.new(X2t.new.version, 'Ppt to Pptx')
result_sets = palladium.get_result_sets(StaticData::POSITIVE_STATUSES)
files = s3.get_files_by_prefix('ppt/')
file_data = nil
describe 'Conversion ppt files to pptx' do
  (files - result_sets.map { |result_set| "ppt/#{result_set}" }).each do |file|
    it File.basename(file) do
      s3.download_file_by_name(file, StaticData::TMP_DIR)
      file_data = X2t.new.convert("#{StaticData::TMP_DIR}/#{File.basename(file)}", :pptx)
      expect(File.exist?(file_data[:tmp_filename])).to be_truthy
      expect(OoxmlParser::Parser.parse(file_data[:tmp_filename])).to be_with_data unless StaticData::EMPTY_FILES.include?(File.basename(file))
    end
  end

  after :each do |example|
    FileHelper.clear_tmp
    palladium.add_result(example, file_data)
  end
end
