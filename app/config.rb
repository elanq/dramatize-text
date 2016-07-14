module App
  # configuration wrapper
  class Config
    def initialize
      Dotenv.load
    end
  end
end
