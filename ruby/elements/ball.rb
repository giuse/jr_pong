module Elements
  class Ball < Base
    include ::Math

    attr_reader  :init_x, :init_y, :init_ang, :paddle,
                 :left_wall, :right_wall, :ceiling, :bottom
    attr_writer  :x, :y
    attr_accessor :ang

    def initialize img_path, init_data, container_size, paddle
      super img_path
      @init_x, @init_y, @init_ang = init_data

      # Bind to paddle (bouncing mechanics)
      @paddle = paddle

      # Screen boundaries
      cont_width, cont_height = container_size
      @left_wall = @ceiling = 0
      @right_wall = cont_width - width
      @bottom = cont_height
    end

    #######################
    # Location predicates #
    #######################

    def touches_left_wall?
      x <= left_wall
    end
    def touches_right_wall?
      x >= right_wall
    end
    def touches_sides?
      touches_left_wall? || 
      touches_right_wall?
    end
    def touches_ceiling?
      y <= ceiling
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
      x.between?(paddle.left, paddle.left + paddle.corner_size) 
    end
    def touches_right_paddle_corner?
      x.between?(paddle.right - paddle.corner_size, paddle.right) 
    end
    def fallen?
      y >= bottom + height - 1 # `+height-1` for "almost out of screen"
    end

    #######################
    # Movement directives #
    #######################

    def bounce_sides
      self.ang = (PI-ang) % (2*PI) # wikipedia -> module -> negative numbers
    end

    def bounce_up_down
      self.ang = (-ang) % (2*PI) # would be `2*PI-ang`, but `%` chomps it anyway
    end

    def move delta, speed
      self.x += speed * delta * cos(ang)
      self.y -= speed * delta * sin(ang) # y axis points downwards
    end

    ##################
    # Game mechanics #
    ##################

    def reset
      self.x   = init_x
      self.y   = init_y
      self.ang = init_ang
    end

    def update container, delta, input, game_speed
      bounce_sides   if touches_sides?
      bounce_up_down if touches_up_down?
      move  delta, game_speed
    end

  end # class
end # module
