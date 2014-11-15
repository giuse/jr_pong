module Elements

  class Ball
    include Constants::Ball

    attr_reader  :img, :init_x, :init_y, :init_ang,
                 :min_x, :min_y, :max_x, :max_y
    attr_accessor  :x, :y, :ang

    def initialize img_path, init_data, container_size
      @img = Image.new  img_path
      @init_x, @init_y, @init_ang = init_data

      # Screen boundaries
      cont_width, cont_height = container_size
      @min_x = @min_y = 0
      @max_x = cont_width - width
      @max_y = cont_height
      reset
    end
    
    # TODO: delegators/forwardable
    def width()  img.width end
    def height() img.height end

    def reset
      self.x   = init_x
      self.y   = init_y
      self.ang = init_ang
    end

    def draw
      img.draw  x, y
    end

    ##################
    # Game mechanics #
    ##################

    def touches_wall?
      x > max_x || 
      y < min_y ||
      x < min_x
    end

    def update container, delta, speed
      self.x += speed * delta * Math.cos(ang * RAD)
      self.y -= speed * delta * Math.sin(ang * RAD)

      rotate if touches_wall?
    end

    def fallen?
      y > max_y
    end

    def rotate
      self.ang = (ang + 90) % 360
    end
  end

end
