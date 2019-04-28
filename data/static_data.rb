# class with some constants and static data
class StaticData
  LIBS_ARRAY = %w[libDjVuFile.so libdoctrenderer.so libHtmlFile.so libHtmlRenderer.so
                  libicudata.so.58 libicuuc.so.58 libPdfReader.so libUnicodeConverter.so
                  libXpsFile.so libPdfWriter.so libXpsFile.so libkernel.so libgraphics.so].freeze

  PROJECT_BIN_PATH = "#{File.join(File.dirname(__FILE__), '/..')}/bin".freeze
  FONTS_PATH = "#{File.join(File.dirname(__FILE__), '/..')}/assets/fonts".freeze
  CONVERSION_STRAIGHT = {
    docx: %i[doct odt rtf],
    xlsx: %i[xlst],
    pptx: %i[pptt]
  }.freeze

  CONVERSION_FROM_XML = {
    docx: %i[txt],
    xlsx: %i[csv]
  }.freeze

  TMP_DIR = "#{File.join(File.dirname(__FILE__), '/..')}/tmp".freeze
  NEW_FILES_DIR = "#{File.join(File.dirname(__FILE__), '/..')}/assets/files/new".freeze
  BROKEN_FILES_DIR = "#{File.join(File.dirname(__FILE__), '/..')}/assets/files/broken".freeze

  EMPTY_FILES = ['empty(слайдов нет).ppt', 'empty.rtf', 'new.rtf'].freeze

  PROJECT_NAME = 'X2t testing'.freeze
  PALLADIUM_SERVER = 'palladium.teamlab.info'.freeze
  POSITIVE_STATUSES = %w[passed passed_2].freeze

  def self.get_palladium_token
    return ENV['PALLADIUM_TOKEN'] if ENV['PALLADIUM_TOKEN']

    File.read("#{ENV['HOME']}/.palladium/token")
  end
end
