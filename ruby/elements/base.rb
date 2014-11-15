module Elements

  # Base definition of an element.
  # Element classes are supposed to subclass this.
  #
  # Provides initialization, x, y, width/height, draw.
  # Forces implementation of reset and update.
  class Base
    attr_reader :x, :y, :img

    def initialize img_path
      @img = Image.new img_path
      reset
    end

    # TODO: delegators/forwardable
    def width()  img.width end
    def height() img.height end


    def draw
      @img.draw  x, y
    end

    def reset
      raise NotImplementedError
    end

    def update
      raise NotImplementedError
    end
  end # class
end # module
