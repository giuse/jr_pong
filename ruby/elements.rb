
class Background
  def initialize img_path
    @img = Image.new img_path
  end

  def draw
    @img.draw  0, 0
  end
end


class Ball

  attr_reader  :img, :init_x, :init_y, :init_ang
  attr_accessor  :x, :y, :ang

  def initialize img_path, init_data
    @init_x, @init_y, @init_ang = init_data
    @img = Image.new img_path
    reset
  end
  
  # TODO: delegators/forwardable
  def width() img.width end
  def height() img.height end

  def reset
    @x = init_x
    @y = init_y
    @ang = init_ang
  end

  def draw
    img.draw  x, y
  end
end
