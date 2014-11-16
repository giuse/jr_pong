require 'constants'
require 'elements'

# This class works by calling `init` upon construction, then `update`
# and `render` at each timestep.
#
class SimplePong < BasicGame
  # Modules defined in ruby/constants.rb
  include Constants::Graphics
  include Constants::Dynamics
  include Constants::Elements::Paddle
  include Constants::Elements::Ball
  include Constants::Elements::Message
  include Elements

  attr_reader :objs, :ball, :paddle, :help_msg, :score_msg
  attr_accessor :game_speed, :start_time, :max_score

  # Main game initialization
  #
  def init container
    # Array of objects to be drawn in correct order
    @objs = []
    objs << (Background.new  BG_IMG)
    objs << (@paddle = Paddle.new  PADDLE_IMG, PADDLE_INIT, WALLS(container))
    objs << (@ball = Ball.new  BALL_IMG, BALL_INIT, STRUCTURE(container), paddle)
    # Playing instructions are displayed on bottom of the screen
    @help_msg = Message.new 'Arrows to control, ESC to quit',
             FONT_SIZE, container.height - MESSAGE_HEIGHT
    # Scoring on top of screen
    @max_score = 0
    @start_time = Time.now
    @score_msg = Message.new 'Your score: ', FONT_SIZE, MESSAGE_HEIGHT
    # Prepare everything to run
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
