# Main
# The rest of the project is located in folder `ruby/`

# Java requirements
$:.push File.expand_path('../lib', __FILE__)
require 'java'
require 'lwjgl.jar'
require 'slick.jar'
java_import org.newdawn.slick.BasicGame
java_import org.newdawn.slick.GameContainer
java_import org.newdawn.slick.Graphics
java_import org.newdawn.slick.Image
java_import org.newdawn.slick.Input
java_import org.newdawn.slick.SlickException
java_import org.newdawn.slick.AppGameContainer

# Ruby requirements
$:.unshift File.expand_path('../ruby',__FILE__)
require 'pong' # see ruby/pong.rb

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
      raise 'SHOULD NOT REACH HERE'
    end
  end
end

# Application launch
WINDOW_SIZE = [640, 480]
app = AppGameContainer.new SimplePong.new 'Pong'
app.set_display_mode(*WINDOW_SIZE, false)

app.start
