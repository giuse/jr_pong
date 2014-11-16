require 'constants'
require 'elements'

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

  attr_reader :objs, :ball, :paddle, :help_msg, :score_msg
  attr_accessor :game_speed, :start_time, :max_score

  # Main game initialization
  #
  def init container
    # Array of objects to be drawn in correct order
    @objs = []
    # Background is a fullscreen png
    objs << (Elements::Background.new  BG_IMG)
    # Paddle moves along a fixed y, and x corresponds to its left corner
    objs << (@paddle = Elements::Paddle.new  PADDLE_IMG, [200, PADDLE_HEIGHT],
              container.width)
    # Ball has a x and y coordinate, plus angle of motion direction
    objs << (@ball = Elements::Ball.new  BALL_IMG, [200, 200, nil],
              [container.width, container.height], paddle)
    # Playing instructions are displayed on bottom of the screen
    @help_msg = Elements::Message.new 'Arrows to control, ESC to quit',
             FONT_SIZE, container.height - MESSAGE_HEIGHT
    # Scoring on top of screen
    @max_score = 0
    @start_time = Time.now
    @score_msg = Elements::Message.new 'Your score: ',
             FONT_SIZE, MESSAGE_HEIGHT
    reset
  end

  def score
    ((Time.now - start_time) * 10).round
  end

  # Main rendering function
  #
  def render container, graphics
    objs.each &:draw
    help_msg.draw  graphics, " - ball angle is #{ball.ang/(::Math::PI/4)}/4 PI"
    score_msg.draw  graphics, "#{score} - max score: #{max_score}"
  end

  def grab_input container
    container.get_input.tap do |input|
      container.exit if input.is(:esc)    
    end
  end

  def reset
    self.max_score = [max_score, score].max
    self.start_time = Time.now
    self.game_speed = GAME_SPEED
    objs.each(&:reset)
  end

  # Main updating function
  #
  def update container, delta
    self.game_speed += GAME_SPEED_INCREMENT # come get some!
    input = grab_input  container
    objs.each do |obj| 
      obj.update(container, delta, input, game_speed)
    end
    reset if ball.fallen?
  end
end
