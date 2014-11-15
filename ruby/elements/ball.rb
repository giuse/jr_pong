module Elements
  class Ball < Base
    include ::Math

    attr_reader  :init_x, :init_y, :init_ang,
                 :min_x, :min_y, :max_x, :max_y,
                 :paddle, :corner_size
    attr_writer  :x, :y
    attr_accessor :ang

    def initialize img_path, init_data, container_size, paddle
      @init_x, @init_y, @init_ang = init_data
      super img_path

      # Bind to paddle
      @paddle = paddle
      @corner_size = width/2

      # Screen boundaries
      cont_width, cont_height = container_size
      @min_x = @min_y = 0
      @max_x = cont_width - width
      @max_y = cont_height
    end

    #######################
    # Location predicates #
    #######################

    def touches_left_wall?
      x <= min_x
    end
    def touches_right_wall?
      x >= max_x
    end
    def touches_sides?
      touches_left_wall? || 
      touches_right_wall?
    end
    def touches_ceiling?
      y <= min_y
    end
    def touches_paddle?
      x.between?(paddle.left, paddle.right) &&
      y.between?(paddle.y-height, paddle.y-height/10) # no "late catches"
    end
    def touches_up_down?
      touches_ceiling? ||
      touches_paddle?
    end
    def touches_left_paddle_corner?
      x.between?(paddle.left, paddle.left + corner_size) 
    end
    def touches_right_paddle_corner?
      x.between?(paddle.right - corner_size, paddle.right) 
    end
    def fallen?
      y >= max_y + height - 1 # +height-1 for almost-out-of-screen
    end

    #######################
    # Movement directives #
    #######################

    def bounce_sides
      self.ang = (PI-ang) % (2*PI)
    end

    def bounce_up_down
      self.ang = -ang % (2*PI) # would be `2*PI-ang`, but module eats it
    end

    def move delta, speed
      self.x += speed * delta * cos(ang)
      self.y -= speed * delta * sin(ang)
    end

    ##################
    # Game mechanics #
    ##################

    def reset
      self.x   = init_x
      self.y   = init_y
      self.ang = init_ang || PI/4
    end

    def update container, delta, speed
      bounce_sides   if touches_sides?
      bounce_up_down if touches_up_down?
      move  delta, speed
    end

  end # class
end # module
