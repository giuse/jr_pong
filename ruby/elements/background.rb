module Elements
  class Background < Base
    def initialize *args
      super # parent's `#initialize` - same as `super(*args)`
      @x=@y=0
    end
    def reset()   end
    def update(*) end
  end
end
