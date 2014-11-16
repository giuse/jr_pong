### DISCLAIMER
This game is just a personal test for JRuby, java videogame libraries, and my current state on the Ruby path. Also, it is meant to be shared with non-rubist friends. It's just a "weekend project", and it all started from here:
http://www.rubyinside.com/video-game-ruby-tutorial-5726.html
Dear fellow Peter Cooper is responsible for the main idea, the graphics, inspiration, support, installation, all the initial code (hand-transcripted from the page) and I guess some of the final one too. Please delegate all copyright, ownership, licenses and whatever to the URL above.
Thanks to the Technology Astronauts for the hardware and the teaching, in particular "your value is in the skills you own, not the code". Ways to go Peter, thanks a bunch! :)

### Installation
- Install `rvm` and `jruby` with `\curl -sSL https://get.rvm.io | bash -s stable --ruby=jruby`
- Clone the project with `git clone git@github.com:giuseppecuccu/jr_pong.git`, and `cd` into it
- Check ruby's fine with `ruby -v` (should return `jruby` + version)
- Install prerequisite libraries (`gems`) with `bundle install`
- Launch the game from the main folder with `ruby jr_pong.rb`

### Remember that in Ruby:
- Variable names starting with an `@` refer to instance variables, and as such they have instance scope and visibility
- Instance variables do not need declaration, and have `nil` value until assigned otherwise
- Variable names without `@` are local to the function scope
- Variable names all in capital letters are constants
- Method `attr_reader` generates getters for the variables named in the parameters - respectively `attr_writer` for setters, and `attr_accessor` for both
- Multiple assignment is possible (es. `a,b,c=[1,2,3]; print b #=> 2`)
- Parenthesis after methods names are optional (both method declaration and calling with parameters)
- Column `:` in front of a name defines a symbol, see it as a sort of efficient lightweight string for fast name comparisons
- By convention, `Class#method` refers to an instance method, `Class::method` is a class method, `Class.method` is an usage example
- Keyword `include` means the content of the named module is "copy and pasted" in place, similarly to C inclusion of files
- "When Java is involved, always fill in the full prototype"
- In Ruby, like Java, everything is passed "by reference", but then copies are made by some functions as return values.
- The splat operator `*` "captures all remaining arguments in an array" when put in front of a function parameter name, and "passes all content of an array" when in front of an Array. This means that `def f(*args) g(*args) end` means that `g` is called with exactly the same parameters as `f` (practically an alias, like calling `alias_method :g, :f`).

### TODO
- scoring and best score
- refresh-based bug that sticks ball to walls at increasing speed - maybe weight the "late-catch" guard by game speed?
