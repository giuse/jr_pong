# I find myself keeping the magic numbers secluded and organized anyway, 
# I might just as well let the program understand the separation too.

module Configuration

  module Application
    WINDOW_SIZE = [640, 480]
  end

  module Graphics
    GRAPHICS_PATH = 'graphics'
    BG_IMG     = File.join(GRAPHICS_PATH, 'bg.png')
    BALL_IMG   = File.join(GRAPHICS_PATH, 'ball.png')
    PADDLE_IMG = File.join(GRAPHICS_PATH, 'paddle.png')
  end

  module Dynamics
    GAME_INIT_SPEED = 0.3
    GAME_SPEED_INCREMENT = 0.00005
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
      # Ball is initialized at given coordinates, plus angle of motion direction
      BALL_INIT_X = 200
      BALL_INIT_Y = 200
      BALL_INIT_ANG = ::Math::PI/4
      # Small random angle radius to make the ball bounce funny :)
      SRANG_RADIUS = ::Math::PI/8
      BALL_INIT = [BALL_INIT_X, BALL_INIT_Y, BALL_INIT_ANG, SRANG_RADIUS]
    end

    module Message
      FONT_SIZE = 8
      MESSAGE_HEIGHT = 30
    end
  end
end
