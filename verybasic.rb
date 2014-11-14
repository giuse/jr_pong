$:.push File.expand_path('../lib', __FILE__)

require "java"
require "lwjgl.jar"
require "slick.jar"

java_import org.newdawn.slick.BasicGame
java_import org.newdawn.slick.GameContainer
java_import org.newdawn.slick.Graphics
java_import org.newdawn.slick.Image
java_import org.newdawn.slick.Input
java_import org.newdawn.slick.SlickException
java_import org.newdawn.slick.AppGameContainer

class Demo < BasicGame

  # When Java is involved, always fill in the prototype  
  def init container
    @bg = Image.new 'bg.png'
    @ball = Image.new 'ball.png'
    @paddle = Image.new 'paddle.png'
    @paddle_x = 200
    @ball_x = 200
    @ball_y = 200
    @ball_angle = 45
  end

  def render container, graphics
    @bg.draw 0,0
    @ball.draw @ball_x, @ball_y
    @paddle.draw @paddle_x, 400
    graphics.draw_string('JRuby Demo (ESC to quit)', 8, container.height - 30)
  end

  def update container, delta
    # Grab input
    input = container.get_input
    container.exit if input.is_key_down Input::KEY_ESCAPE
  end
end

app = AppGameContainer.new Demo.new 'SlickDemo'
app.set_display_mode 640, 480, false
app.start
