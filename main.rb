require_relative 'app/app.rb'

Dotenv.load
converter = App::Converter.new

filtered_converter = App::Converter.new
filtered_converter.darken
                  .place_text("")
                  .write_to('/Volumes/EQ-DOCS/test-folder/generated_image_with_filter.jpg')
