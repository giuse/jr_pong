
class Background
  def initialize img_path
    @img = Image.new img_path
  end

  def draw
    @img.draw  0, 0
  end

  def reset() end
end


class Ball

  attr_reader  :img, :init_x, :init_y, :init_ang
  attr_accessor  :x, :y, :ang

  def initialize img_path, init_data
    @img = Image.new  img_path
    @init_x, @init_y, @init_ang = init_data
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


class Paddle

  attr_reader  :img, :init_x, :y
  attr_accessor  :x

  def initialize img_path, init_data
    @img = Image.new  img_path
    @init_x, @y = init_data
    reset
  end
  
  # TODO: delegators/forwardable
  def width() img.width end
  def height() img.height end

  def reset
    @x = init_x
  end

  def draw
    img.draw  x, y
  end
end

