# class with some constants and static data
class StaticData
  LIBS_ARRAY = %w[libDjVuFile.so libdoctrenderer.so libHtmlFile.so libHtmlRenderer.so
                  libicudata.so.58 libicuuc.so.58 libPdfReader.so libUnicodeConverter.so
                  libXpsFile.so libPdfWriter.so libXpsFile.so libkernel.so libgraphics.so].freeze

  PROJECT_BIN_PATH = "#{File.join(File.dirname(__FILE__), '/..')}/bin".freeze
end
