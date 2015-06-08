# Introduction To Gosu
## Getting Started
We first have to create a file which starts up the game when run.

`$ touch game.rb`

In this file, we need to do three things:

1. require the Gosu framework
2. instantiate a `GameWindow` object.
3. run the `#show` method on this `GameWindow` object to display the game window.

```ruby
require 'gosu'

game_window = GameWindow.new
game_window.show
```

However, we need to implement the `GameWindow` class. We will create a new file which defines that class.

`$ touch game_window.rb`

We will also have to require this file in the `game.rb` file. So your `game.rb` file will now look like this.

```ruby
require 'gosu'
require_relative 'game'

game_window = GameWindow.new
game_window.show
```

Any additional files that are needed will be required in this manner in the `game.rb` file.

Let's now implement the `GameWindow` class. This class needs to inherit from the [Gosu::Window](https://www.libgosu.org/rdoc/Gosu/Window.html)
and make a call to super with the screen width and screen height within `#initialize` to set up the Gosu framework functionality.

```ruby
class GameWindow < Gosu::Window
  SCREEN_WIDTH = 600
  SCREEN_HEIGHT = 900

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT)
  end

  def update
  end

  def draw
  end
end
```
The `#update` and `#draw` methods are methods that get called 60 times every second once the game is started.
The `#update` method should contain the logic to update the state of your objects and 
the draw method should contain the logic to redraw the screen.

Let's start by creating a simple menu screen that says "Press Enter To Play". 
To do this, we are going to set the initial view of the game window to be menu.

```ruby
class GameWindow < Gosu::Window
  SCREEN_WIDTH = 600
  SCREEN_HEIGHT = 900

  attr_accessor :view

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT)
    @view = :menu
  end

  def update
  end

  def draw
    if view == :menu
    end
  end
end

```

If the view of the window is menu, then I want to draw a [Gosu::Font](https://www.libgosu.org/rdoc/Gosu/Font.html#) object. This object
will be instantiated when we initialize the game window.  The `#draw` method 
will be called on the object with the text, x coordinate, y coordinate, and z coordinate arguments to actually display it on the game window.
