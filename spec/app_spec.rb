require_relative 'spec_helper.rb'

RSpec.describe 'app' do
  before { Dotenv.load }
  let(:random_image) { "#{ENV['UNSPLASH_WEB']}/400/400" }

  context 'bot' do
    it 'should accept text request'
  end

  context 'config' do
    it 'check return correct dotenv configuration' do
      expect(ENV['UNSPLASH_WEB']).not_to be nil
    end
  end

  context 'retriever' do
    it 'should get random image from unsplash' do
      expect(random_image).not_to be nil
    end
  end

  context 'converter' do
    # let(:image) { App::Converter.build('test') }
  end
end
