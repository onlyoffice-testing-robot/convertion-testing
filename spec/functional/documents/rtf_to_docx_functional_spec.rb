require 'rspec'
s3 = OnlyofficeS3Wrapper::AmazonS3Wrapper.new
palladium = PalladiumHelper.new(X2t.new.version, 'Rtf to Docx')
result_sets = palladium.get_result_sets(StaticData::POSITIVE_STATUSES)
files = s3.get_files_by_prefix('rtf/')
describe 'Conversion rtf files to docx' do
  before :each do
    @tmp_dir = FileHelper.create_tmp_dir.first
  end
  (files - result_sets.map { |result_set| "rtf/#{result_set}" }).each do |file|
    it File.basename(file) do
      p file
      s3.download_file_by_name(file, @tmp_dir)
      @file_data = X2t.new.convert("#{@tmp_dir}/#{File.basename(file)}", :docx, @tmp_dir)
      expect(File.exist?(@file_data[:tmp_filename])).to be_truthy
      expect(OoxmlParser::Parser.parse(@file_data[:tmp_filename]).with_data?).to be_truthy
    end
  end

  after :each do |example|
    FileHelper.delete_tmp(@tmp_dir)
    palladium.add_result(example, @file_data)
  end
end
