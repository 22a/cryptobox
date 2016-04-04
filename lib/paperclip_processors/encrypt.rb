module Paperclip
  class Encrypt < Processor

    def initialize file, options = {}, attachment = nil
      super
      @file           = file
      @attachment     = attachment
      @current_format = File.extname(@file.path)
      @format         = options[:format]
      @basename       = File.basename(@file.path, @current_format)
    end

    def make
      file_content = File.read(@file.path)
      enc = SymmetricEncryption.encrypt file_content
      temp_file = Tempfile.new([@basename, @format])
      temp_file.write(enc)
      temp_file.flush
      temp_file
    end

  end
end
