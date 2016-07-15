module App
  # build image to  text
  class Converter
    include Magick

    def initialize(size = 1200)
      @size = size
      link = "#{ENV['UNSPLASH_WEB']}/#{size}/#{size}/?random"
      @image = Image.read(link).first
      @orig_image = @image.dup
    end

    def place_text(text)
      # draw object, width, height, x, y, text
      txt = Draw.new
      text = fit_text(text, 900)
      txt.font = 'lib/font/neue.ttf'
      @image.annotate(txt, 0, 0, 0, @size / 8, text) do
        txt.font_weight = 300
        txt.gravity = Magick::NorthGravity
        txt.pointsize = 80
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
      true
    rescue StandardError => _e
      false
    end

    def custom_image=(image)
      @image = image
    end

    def original_image
      @orig_image
    end

    private

    def text_fit?(text, width)
      tmp_image = Image.new(width, 1200)
      drawing = Draw.new
      drawing.font = 'lib/font/neue.ttf'
      drawing.annotate(tmp_image, 0, 0, 0, 0, text) do |txt|
        txt.font_weight = 300
        txt.gravity = Magick::NorthGravity
        txt.pointsize = 80
      end
      metrics = drawing.get_multiline_type_metrics(tmp_image, text)
      (metrics.width < width)
    end

    def fit_text(text, width)
      separator = ' '
      line = ''

      unless text_fit?(text, width) && text.include?(separator)
        i = 0
        text.split(separator).each do |word|
          tmp_line = i == 0 ? line + word : line + separator + word
          if text_fit?(tmp_line, width)
            line += separator unless i == 0
          else
            line += '\n' unless i == 0
          end
          line += word
          i += 1
        end
        text = line
      end
      text
    end
  end
end
