#!/usr/bin/env jruby -J-Djava.library.path=./java

# Java requirements
require 'java'
require 'java/lib/lwjgl.jar'
require 'java/lib/slick.jar'
java_import org.newdawn.slick.BasicGame
java_import org.newdawn.slick.GameContainer
java_import org.newdawn.slick.Graphics
java_import org.newdawn.slick.Image
java_import org.newdawn.slick.Input
java_import org.newdawn.slick.SlickException
java_import org.newdawn.slick.AppGameContainer

# Ruby requirements
$:.unshift File.expand_path('../ruby',__FILE__)
require 'pong'

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
require 'configuration'
include Configuration::Application
app = AppGameContainer.new SimplePong.new 'Pong'
app.set_display_mode(*WINDOW_SIZE, false)

app.start
