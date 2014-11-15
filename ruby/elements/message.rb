module Elements
  class Message < Base
    attr_reader :text, :font_size, :place

    def initialize text, font_size, place
      @text = text
      @font_size = font_size
      @place = place
    end
    
    def draw graphics
      graphics.draw_string  text, font_size, place
    end
    
    def reset()  end
    def update() end
  end
end
