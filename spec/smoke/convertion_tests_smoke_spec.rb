# frozen_string_literal: true

require 'rspec'
palladium = PalladiumHelper.new(x2t.version, 'Conversion tests smoke')

describe 'Conversion tests' do
  before :each do
    @tmp_dir = FileHelper.create_tmp_dir.first
  end

  StaticData::CONVERSION_STRAIGHT.each_pair do |format_from, formats_to|
    formats_to.each do |format|
      it "Check converting from #{format_from} to #{format}" do
        filepath = "#{StaticData::NEW_FILES_DIR}/new.#{format_from}"
        file_data = x2t.convert(filepath, format)
        expect(File.exist?(file_data[:tmp_filename])).to be_truthy
      end
    end
  end

  it 'Check converting from docx to xlsx negative' do
    filepath = "#{StaticData::NEW_FILES_DIR}/new.docx"
    file_data = x2t.convert(filepath, :xlsx)
    expect(File.exist?(file_data[:tmp_filename])).to be_falsey
  end

  it 'Check conversion with files from s3' do
    s3.download_file_by_name('docx/Newsletter.docx', StaticData::TMP_DIR)
    file_data = x2t.convert("#{StaticData::TMP_DIR}/Newsletter.docx", :doct)
    expect(File.exist?(file_data[:tmp_filename])).to be_truthy
  end

  it 'Check conversion errors' do
    filepath = "#{StaticData::BROKEN_FILES_DIR}/It_is_docx_file.xlsx"
    file_data = x2t.convert(filepath, :xlst)
    expect(File.exist?(file_data[:tmp_filename])).to be_falsey
    expect(file_data[:size_after]).to be_nil
    expect(file_data[:x2t_result]).to eq("Couldn't automatically recognize conversion direction from extensions")
  end

  after :each do |example|
    FileHelper.delete_tmp(@tmp_dir)
    palladium.add_result(example)
  end
end
