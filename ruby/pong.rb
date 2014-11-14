require 'constants'

class Pong < BasicGame
  include Constants::Graphics
  include Constants::Dynamics
  include Constants::Misc

  # When Java is involved, always fill in the prototype  
  def init container
    @bg     = Image.new BG
    @ball   = Image.new BALL
    @paddle = Image.new PADDLE
    reset_state
  end

  def reset_state
    @paddle_x = 200
    @ball_x   = 200
    @ball_y   = 200
    @ball_angle = 45
  end

  def render container, graphics
    # Draw background, then ball, then paddle
    @bg.draw 0,0
    @ball.draw @ball_x, @ball_y
    @paddle.draw @paddle_x, PADDLE_HEIGHT
    # Draw message
    graphics.draw_string('PONG - JRuby Demo (ESC to quit)', 
      TEXT_HEIGHT, container.height - 30)
  end

  def update_ball container, delta
    @ball_x += GAME_SPEED * delta * Math.cos(@ball_angle * RAD)
    @ball_y -= GAME_SPEED * delta * Math.sin(@ball_angle * RAD)

    if (@ball_x > container.width - @ball.width) || 
      (@ball_y < 0) || (@ball_x < 0)
      @ball_angle = (@ball_angle + 90) % 360
    end
  end

  def update container, delta
    # Grab input
    input = container.get_input
    container.exit if input.is(:esc)

    if input.is(:left) && @paddle_x > 0
      @paddle_x -= GAME_SPEED * delta
    end

    if input.is(:right) && @paddle_x < container.width - @paddle.width
      @paddle_x += GAME_SPEED * delta
    end

    update_ball container, delta

    if @ball_y > container.height
      reset_state
    end

    if @ball_x >= @paddle_x && @ball_x <= (@paddle_x + @paddle.width) && @ball_y.round >= (PADDLE_HEIGHT - @ball.height)
      @ball_angle = (@ball_angle + 90) % 360
    end
  end
end


# BEWARE - MONKEY PATCHING `Java::OrgNewdawnSlick::Input`!
class Java::OrgNewdawnSlick::Input
  def is key
    case key
      when :esc
        is_key_down Input::KEY_ESCAPE
      when :left
        is_key_down Input::KEY_LEFT
      when :right
        is_key_down Input::KEY_RIGHT
    else
      raise 'SHOULD NOT REACH'
    end
  end
end
