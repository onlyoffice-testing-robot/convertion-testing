require 'rspec'

describe 'Conversion tests' do
  StaticData::CONVERSION_DIRECT.each_pair do |format_from, formats_to|
    formats_to.each do |format_to|
      it "Check converting from #{format_from} to #{format_to}" do
        filepath = "#{StaticData::NEW_FILES_DIR}/new.#{format_from}"
        file_data = X2t.new.convert(filepath, format_to)
        expect(File.exist?(file_data[:tmp_filename])).to be_truthy
      end
    end
  end

  after :all do
    FileHelper.clear_tmp
  end
end