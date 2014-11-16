module Elements
  class Message < Base
    attr_reader :text, :font_size, :place

    def initialize text, font_size, place
      @text = text
      @font_size = font_size
      @place = place
    end
    
    def draw graphics, extra=""
      graphics.draw_string  text+extra, font_size, place
    end
    
    def reset()  end
    def update() end
  end
end
