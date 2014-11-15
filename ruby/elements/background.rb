module Elements
  class Background < Base
    def initialize *args
      super
      @x=@y=0
    end
    def reset()  end
    def update(*) end
  end
end
