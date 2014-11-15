module Elements

  # Base definition of an element.
  # Element classes are supposed to subclass this.
  #
  # Provides initialization, x, y, width/height, draw.
  # Forces implementation of reset and update.
  class Base
    extend Forwardable

    attr_reader :x, :y, :img
    # Delegate `width` and `height` calls to the `img`
    def_delegators :img, :width, :height

    def initialize img_path
      @img = Image.new img_path
      reset
    end

    def draw
      @img.draw  x, y
    end

    def reset
      raise NotImplementedError
    end

    def update container, delta, input, game_speed
      raise NotImplementedError
    end
  end # class
end # module
