module Elements
  class Paddle < Base

    attr_reader  :init_x, :left_wall, :right_wall, :corner_size
    attr_writer  :x
    # build `#left` and `#right` getters (`#x` and `#width` come from `Base`)
    alias_method :left, :x
    def right() x+width end

    def initialize img_path, init_position, wall_placement
      super img_path
      @init_x, @y = init_position
      @corner_size = width/5

      # Horizontal movement boundaries for paddle (y is fixed)
      @left_wall, @right_wall = wall_placement
    end
    
    ##################
    # Game mechanics #
    ##################

    def touches_left_wall?
      left <= left_wall
    end
    
    def touches_right_wall?
      right >= right_wall
    end

    def reset
      self.x = init_x
    end

    def update container, delta, input, speed
      case
        when input.is(:left) && ! touches_left_wall?
          self.x -= speed * delta
        when input.is(:right) && ! touches_right_wall?
          self.x += speed * delta
      else
        # Just ignore other inputs
      end
    end
  end # class
end # module
