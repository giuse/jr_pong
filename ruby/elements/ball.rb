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
    def touches_ceiling?
      y <= min_y
    end
    def touches_wall?
      touches_left_wall? || 
      touches_right_wall? ||
      touches_ceiling?
    end
    def touches_paddle?
      x.between?(paddle.left, paddle.right) &&
      y.between?(paddle.y-height, paddle.y-height/10) # no "late catches"
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

    ##################
    # Game mechanics #
    ##################

    def reset
      self.x   = init_x
      self.y   = init_y
      self.ang = init_ang || NE # north-east - see below, #bounce
    end

    def update container, delta, speed
      try_bounce
      self.x += speed * delta * Math.cos(ang)
      self.y -= speed * delta * Math.sin(ang)
    end

    NE = PI * 1/4
    NO = PI * 3/4
    SO = PI * 5/4
    SE = PI * 7/4
    def try_bounce

      case
        when touches_right_wall?
          case ang
            when NE
              self.ang = NO
            when SE
              self.ang = SO
          else
            # raise "impossible"
          end
          
        when touches_left_wall?
          case ang
            when NO
              self.ang = NE
            when SO
              self.ang = SE
          else
            # raise "impossible"
          end
          
        when touches_ceiling?
          case ang
            when NO
              self.ang = SO
            when NE
              self.ang = SE
          else
            # raise "impossible"
          end

        when touches_paddle?
          case ang
            when SO
              if touches_right_paddle_corner?
                self.ang == NE
              else
                self.ang = NO
              end
            when SE
              if touches_left_paddle_corner?
                self.ang = NO
              else
                self.ang = NE
              end
          else
            # raise "impossible"
          end

      else
        # not touching -> not bouncing
      end

    end
  end # class
end # module
