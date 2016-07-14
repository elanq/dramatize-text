require_relative 'app/app.rb'

Dotenv.load
converter = App::Converter.new
default_image = converter.original_image
converter.place_text('Sekarang pakai text yang sangat panjang sekali kira-kira overlap gak ya')
         .write_to('/Volumes/EQ-DOCS/test-folder/generated_image.jpg')

filtered_converter = App::Converter.new
filtered_converter.custom_image = default_image
filtered_converter.darken
                  .place_text('testing')
                  .write_to('/Volumes/EQ-DOCS/test-folder/generated_image_with_filter.jpg')
