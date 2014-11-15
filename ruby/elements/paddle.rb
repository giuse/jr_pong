module Elements
  class Paddle < Base

    attr_reader  :init_x, :min_x, :max_x
    attr_writer  :x
    alias_method :left, :x
    def right() x+width end

    def initialize img_path, init_data, max_width
      super img_path
      @init_x, @y = init_data

      # Screen boundaries for paddle (y is fixed)
      @min_x = 0
      @max_x = max_width - width
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

    def reset
      self.x = init_x
    end

    def update container, delta, input, speed
      if input.is(:left) && ! touches_left_wall?
        self.x -= speed * delta
      elsif input.is(:right) && ! touches_right_wall?
        self.x += speed * delta
      end
    end
  end # class
end # module
