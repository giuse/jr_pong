require 'constants'

# This class works by calling `init` upon construction, then `update`
# and `render` at each timestep.
#
# The class is monolitic rather than OO for the sake of lighter reading:
# all the game is here, but for the launcher and some constants
#
class SimplePong < BasicGame
  # These modules are defined in ruby/constants.rb
  include Constants::Graphics
  include Constants::Dynamics
  include Constants::Misc

  # Main game initialization
  #
  def init container
    # Background is a fullscreen png
    @bg     = Image.new BG_IMG
    # Ball has a x and y coordinate, plus angle of motion direction
    @ball   = Image.new BALL_IMG
    # Paddle has fixed y, and x corresponds to the left corner
    @paddle = Image.new PADDLE_IMG

    # Screen boundaries for ball
    @min_ball_x = @min_ball_y = 0
    @max_ball_x = container.width - @ball.width
    @max_ball_y = container.height
    # Screen boundaries for paddle (y is fixed)
    @min_paddle_x = 0
    @max_paddle_x = container.width - @paddle.width

    reset_state
  end

  def reset_state
    @paddle_x = 200
    @ball_x   = 200
    @ball_y   = 200
    @ball_angle = 45 # start moving up+right
  end

  # Main rendering function
  #
  def render container, graphics
    # Draw background, then ball, then paddle
    @bg.draw  0,0
    @ball.draw  @ball_x, @ball_y
    @paddle.draw  @paddle_x, PADDLE_HEIGHT
    # Draw message
    text = 'Arrows to control, ESC to quit'
    place = container.height - MESSAGE_HEIGHT
    graphics.draw_string  text, FONT_SIZE, place
  end

  def grab_input container
    input = container.get_input
    container.exit if input.is(:esc)    
    input
  end

  def paddle_touches_left_wall?
    @paddle_x <= @min_paddle_x
  end
  def paddle_touches_right_wall?
    @paddle_x >= @max_paddle_x
  end

  def update_paddle container, delta, input
    if input.is(:left) && ! paddle_touches_left_wall?
      @paddle_x -= GAME_SPEED * delta
    end
    if input.is(:right) && ! paddle_touches_right_wall?
      @paddle_x += GAME_SPEED * delta
    end
  end

  def ball_touches_wall?
    @ball_x > @max_ball_x || 
    @ball_y < @min_ball_y ||
    @ball_x < @min_ball_x
  end

  def update_ball container, delta
    @ball_x += GAME_SPEED * delta * Math.cos(@ball_angle * RAD)
    @ball_y -= GAME_SPEED * delta * Math.sin(@ball_angle * RAD)

    if ball_touches_wall?
      @ball_angle = (@ball_angle + 90) % 360
    end
  end

  def ball_touches_paddle?
    @ball_x >= @paddle_x && 
    @ball_x <= (@paddle_x + @paddle.width) && 
    @ball_y.round >= (PADDLE_HEIGHT - @ball.height)    
  end

  def ball_fallen?
    @ball_y > @max_ball_y
  end

  def ball_paddle_interaction
    if ball_touches_paddle?
      @ball_angle = (@ball_angle + 90) % 360
    end
  end

  # Main updating function
  #
  def update container, delta
    input = grab_input  container
    update_paddle  container, delta, input
    update_ball  container, delta
    reset_state if ball_fallen?
    ball_paddle_interaction
  end
end
