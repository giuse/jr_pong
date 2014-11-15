module Elements
  class Message < Base
    attr_reader :text, :font_size, :place

    def initialize text, font_size, place, ball=nil
      @text = text
      @ball = ball
      @font_size = font_size
      @place = place
    end
    
    def draw graphics
      add = @ball.nil? ? "" : " - ball angle is #{@ball.ang/(::Math::PI/4)}/4 PI"
      graphics.draw_string  text+add, font_size, place
    end
    
    def reset()  end
    def update() end
  end
end
