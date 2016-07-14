# top module
module App
  require 'redis'
  require 'pry'
  require 'rspec'
  require 'RMagick'
  require 'dotenv'
  require 'unsplash'
  require 'httparty'
  require 'telegram/bot'

  require_relative 'converter.rb'
  require_relative 'config.rb'
  require_relative 'retriever.rb'
end
