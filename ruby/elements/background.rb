module Elements
  class Background
    def initialize img_path
      @img = Image.new img_path
    end

    def draw
      @img.draw  0, 0
    end

    def reset() end
  end
end
