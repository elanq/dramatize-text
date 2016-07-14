module App
  # build image to  text
  class Converter
    include Magick

    def initialize(size = 1200)
      @size = size
      link = "#{ENV['UNSPLASH_WEB']}/#{size}/#{size}/?random"
      @image = Image.read(link).first
    end

    def place_text(text)
      # draw object, width, height, x, y, text
      txt = Draw.new
      @image.annotate(txt, 0, 0, 0, 0, text) do
        txt.gravity = Magick::NorthGravity
        txt.pointsize = 70
        txt.fill = '#ffffff'
      end
      self
    end

    def darken
      @image = @image.level(-QuantumRange * 0.25, QuantumRange * 1.25)
      self
    end

    def write_to(path)
      path = File.new(path, 'w+') if path.class == String
      @image.write(path.path)
      path
    end

    def custom_image=(image)
      @image = image
    end

    def image
      @image
    end
  end
end
