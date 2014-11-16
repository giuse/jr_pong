# I find myself keeping the magic numbers secluded and organized anyway, 
# I might just as well let the program understand the separation too.

module Constants
  module Graphics
    GRAPHICS_PATH = 'graphics'
    BG_IMG     = File.join(GRAPHICS_PATH, 'bg.png')
    BALL_IMG   = File.join(GRAPHICS_PATH, 'ball.png')
    PADDLE_IMG = File.join(GRAPHICS_PATH, 'paddle.png')
  end

  module Dynamics
    GAME_SPEED = 0.3
    GAME_SPEED_INCREMENT = 0.0005
    def WALLS(container) [0, container.width] end
    def BOTTOM_TOP(container) [container.height, 0] end
    def STRUCTURE(container) [WALLS(container), BOTTOM_TOP(container)] end
  end

  module Elements
    module Paddle
      # Paddle moves along a fixed y, and x corresponds to its left corner
      PADDLE_INIT = [200, 400]
    end
    
    module Ball
      # Ball has a x and y coordinate, plus angle of motion direction
      BALL_INIT = [200, 200, ::Math::PI/4]
    end

    module Message
      FONT_SIZE = 8
      MESSAGE_HEIGHT = 30
    end
  end
end
