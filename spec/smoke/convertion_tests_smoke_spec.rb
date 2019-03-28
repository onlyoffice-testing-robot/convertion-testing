require 'rspec'
s3 = OnlyofficeS3Wrapper::AmazonS3Wrapper.new
palladium = PalladiumHelper.new(X2t.new.version, 'Conversion tests smoke')

describe 'Conversion tests' do
  StaticData::CONVERSION_STRAIGHT.each_pair do |format_from, formats_to|
    formats_to.each do |format_to|
      it "Check converting from #{format_from} to #{format_to}" do
        filepath = "#{StaticData::NEW_FILES_DIR}/new.#{format_from}"
        file_data = X2t.new.convert(filepath, format_to)
        expect(File.exist?(file_data[:tmp_filename])).to be_truthy
      end
    end
  end

  it 'Check converting from docx to xlsx negative' do
    filepath = "#{StaticData::NEW_FILES_DIR}/new.docx"
    file_data = X2t.new.convert(filepath, :xlsx)
    expect(File.exist?(file_data[:tmp_filename])).to be_falsey
  end

  it 'Check conversion with files from s3' do
    s3.download_file_by_name('files_for_tests/docx/Newsletter.docx', StaticData::TMP_DIR)
    file_data = X2t.new.convert("#{StaticData::TMP_DIR}/Newsletter.docx", :doct)
    expect(File.exist?(file_data[:tmp_filename])).to be_truthy
  end

  after :each do |example|
    FileHelper.clear_tmp
    palladium.add_result_and_log(example)
  end
end
