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
      temp_file = Tempfile.new([@basename, @format])
      puts @format
      temp_file.write("fuck you")
      temp_file.flush
      temp_file
    end

  end
end
