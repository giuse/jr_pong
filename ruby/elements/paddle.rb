module Elements

  class Paddle

    attr_reader  :img, :init_x, :min_x, :max_x, :y
    attr_accessor  :x

    def initialize img_path, init_data, max_width
      @img = Image.new  img_path
      @init_x, @y = init_data

      # Screen boundaries for paddle (y is fixed)
      @min_x = 0
      @max_x = max_width - width

      reset
    end
    
    # TODO: delegators/forwardable
    def width()  img.width end
    def height() img.height end

    def reset
      self.x = init_x
    end

    def draw
      img.draw  x, y
    end

    ##################
    # Game mechanics #
    ##################

    def touches_left_wall?
      x <= min_x
    end
    def touches_right_wall?
      x >= max_x
    end

    def update container, delta, input, speed
      if input.is(:left) && ! touches_left_wall?
        self.x -= speed * delta
      elsif input.is(:right) && ! touches_right_wall?
        self.x += speed * delta
      end
    end
  end
  
end
