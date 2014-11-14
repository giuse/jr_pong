
module Constants
  module Graphics
    GRAPHICS_PATH = 'graphics'
    BG_IMG        = 'bg.png'
    BALL_IMG      = 'ball.png'
    PADDLE_IMG    = 'paddle.png'

    BG     = File.join(GRAPHICS_PATH, BG_IMG)
    BALL   = File.join(GRAPHICS_PATH, BALL_IMG)
    PADDLE = File.join(GRAPHICS_PATH, PADDLE_IMG)

    PADDLE_HEIGHT = 400
  end

  module Dynamics
    GAME_SPEED = 0.3
  end

  module Misc
    RAD = ::Math::PI / 180
    TEXT_HEIGHT = 8
  end
end
