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
    PADDLE_HEIGHT = 400
  end

  module Misc
    FONT_SIZE = 8
    MESSAGE_HEIGHT = 30
  end
end
