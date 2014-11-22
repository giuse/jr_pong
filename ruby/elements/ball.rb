module Elements
  class Ball < Base
    include ::Math

    attr_reader  :init_x, :init_y, :init_ang, :paddle,
                 :left_wall, :right_wall, :ceiling, :bottom
    attr_writer  :x, :y
    attr_accessor :ang

    def initialize img_path, init_data, box_structure, paddle
      super img_path
      @init_x, @init_y, @init_ang = init_data

      # Bind to paddle (bouncing mechanics)
      @paddle = paddle

      # Screen boundaries
      (@left_wall, @right_wall), (@bottom, @ceiling) = box_structure
      @right_wall -= width #looks nicer on screen
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
    # Movement predicates #
    #######################

    def going_up?
      ang.between?(0,PI)
    end

    def going_down?
      ang.between?(PI,2*PI)
    end

    def going_left?
      ang.between?(PI*1/2,PI*3/2)
    end

    def going_right?
      ang.between?(0,PI*1/2) ||
      ang.between?(PI*3/2,2*PI)
    end

    #######################
    # Movement directives #
    #######################

    # small random angle
    def rang
      radious = PI/5
      rand(-radious..radious)
    end

    def bounce_left
      bounce_sides if going_left?
    end

    def bounce_right
      bounce_sides if going_right?
    end

    def bounce_up
      bounce_up_down if going_up?
    end

    def bounce_down
      bounce_up_down if going_down?
    end

    def bounce_sides
      self.ang = (PI-ang + rang) % (2*PI) # wikipedia -> module -> negative numbers
      # BOUND `x` SO THAT IT DOESN'T PENETRATE!
    end

    def bounce_up_down
      self.ang = (-ang + rang) % (2*PI) # would be `2*PI-ang`, but `%` chomps it anyway
      # BOUND `y` SO THAT IT DOESN'T PENETRATE!
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
      bounce_left  if touches_left_wall?
      bounce_right if touches_right_wall?
      bounce_up    if touches_ceiling?
      bounce_down  if touches_paddle?
      move  delta, game_speed
    end

  end # class
end # module
