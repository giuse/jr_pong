module Elements

  # Base definition of an element.
  # Element classes are supposed to subclass this.
  #
  class Base
    attr_reader :x, :y

    def initialize img_path
      @img = Image.new img_path
    end

    def draw
      @img.draw  x, y
    end

    def reset
      raise NotImplementedError
    end

    def update
      raise NotImplementedError
    end
  end
end
