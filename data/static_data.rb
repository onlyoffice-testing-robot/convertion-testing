# class with some constants and static data
class StaticData
  LIBS_ARRAY = %w[libDjVuFile.so libdoctrenderer.so libHtmlFile.so libHtmlRenderer.so
                  libicudata.so.58 libicuuc.so.58 libPdfReader.so libUnicodeConverter.so
                  libXpsFile.so libPdfWriter.so libXpsFile.so libkernel.so libgraphics.so].freeze

  PROJECT_BIN_PATH = "#{File.join(File.dirname(__FILE__), '/..')}/bin".freeze
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
end
