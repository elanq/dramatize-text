require_relative 'app/app.rb'

Dotenv.load
logger = Logger.new(STDOUT)
Telegram::Bot::Client.run(ENV['TELEGRAM_TOKEN'], logger: logger) do |bot|
  bot.listen do |message|
    message_params = {
      chat_id: message.chat.id
    }
    if message.text.length > 20
      converter = App::Converter.new
      file_loc = "/Volumes/EQ-DOCS/test-folder/#{Random.new_seed}.jpg"
      file_type = 'image/jpeg'
      state = converter.darken
                       .place_text(message.text)
                       .write_to(file_loc)
      if state
        message_params[:photo] = Faraday::UploadIO.new(file_loc, file_type)
        bot.api.send_photo message_params
      else
        message_params[:text] = 'Terdapat kesalahan dalam memproses gambar'
        bot.api.send_message(message_params)
      end
    else
      message_params[:text] = 'Pesan harus melebihi 20 karakter'
      bot.api.send_message(message_params)
    end
  end
end
