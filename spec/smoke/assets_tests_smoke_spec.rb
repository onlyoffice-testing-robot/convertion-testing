require 'rspec'

palladium = PalladiumHelper.new(X2t.new.version, 'Assets tests smoke')

describe 'Assets tests' do

  describe 'libraries' do
    StaticData::LIBS_ARRAY.each do |lib|
      it "Lib #{lib} exist check" do
        expect(File.exist?("bin/#{lib}")).to be_truthy
      end
    end
  end

  describe 'x2t' do
    it 'x2t exist check' do
      expect(File.exist?('bin/x2t')).to be_truthy
    end

    it 'x2t version non empty check' do
      expect(X2t.new.version).not_to be_empty
    end
  end

  after :each do |example|
    palladium.add_result_and_log(example)
  end
end