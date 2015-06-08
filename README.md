# Introduction To Gosu
## Getting Started
If you have not done so already. Install the Gosu gem.

`$ gem install gosu`

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

##Menu Screen

Let's start by creating a simple menu screen that says "Press 'a' To Play".
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
will be instantiated with the height of the font when we initialize the game window.  The `#draw` method
will be called on the object with the text, x coordinate, y coordinate, and z coordinate arguments to actually display it on the game window.

```ruby
class GameWindow < Gosu::Window
  SCREEN_WIDTH = 600
  SCREEN_HEIGHT = 900
  FONT_HEIGHT_MEDIUM = 50

  attr_accessor :view
  attr_reader :menu_font

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT)
    @view = :menu
    @menu_font = Gosu::Font.new(FONT_HEIGHT_MEDIUM)
  end

  def update
  end

  def draw
    if view == :menu
      menu_font_text = "Press 'a' To Play"
      menu_font_x_coordinate = 88.75
      menu_font_y_coordinate = 100
      menu_font_z_coordinate = 0
      menu_font.draw(
        menu_font_text,
        menu_font_x_coordinate,
        menu_font_y_coordinate,
        menu_font_z_coordinate
      )
    end
  end
end
```

I am going to clean up my draw method by extracting the drawing of the menu to a method called `draw_menu`

```ruby
def draw
  if view == :menu
    draw_menu
  end
end

def draw_menu
  menu_font_text = "Press 'a' To Play"
  menu_font_x_coordinate = 88.75
  menu_font_y_coordinate = 100
  menu_font_z_coordinate = 0
  menu_font.draw(
    menu_font_text,
    menu_font_x_coordinate,
    menu_font_y_coordinate,
    menu_font_z_coordinate
  )
end
```
To see what we have so far, simply execute

`$ ruby game.rb`

Something to note is the (0,0) coordinate is the top left corner of the screen. X increases from left to right, and Y increases
from top to bottom. The z coordinate will refer to how to overlay images. An image with a z coordinate of 0 will be covered by another
image with a z coordinate of 1.

##Create A Paddle

The next step is to show the actual game when the user hits 'a'. We can do this by changing the view in the `#update` method whenever
the user hits the 'a' button while in the menu view. This is easily done by using `Game::Window`'s `#button_down?` function and passing
in the button to be pressed. A list of how to refer to the buttons is found in the [Gosu Module Doc page](https://www.libgosu.org/rdoc/Gosu.html#button_down%3F-class_method).

```ruby
  def update
    if view == :menu && button_down?(Gosu::KbA)
      self.view = :game
    end
  end
```
Let's make a rectangular paddle that moves to the x-coordinate of where the mouse pointer is located. First we need to create a Paddle object and with initial coordinates.
```ruby
  attr_accessor :view, :paddle
  attr_reader :menu_font

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT)
    @view = :menu
    @menu_font = Gosu::Font.new(FONT_HEIGHT_MEDIUM)
    @paddle = Paddle.new(SCREEN_WIDTH / 2, 800, 0)
  end
```
Then we want to update the paddle's position to be the same as of the mouse's position.
We can use the `Gosu::Window`'s `#mouse_x` function to obtain the current x_coordinate of the mouse pointer.
```ruby
  def update
    if view == :menu && button_down?(Gosu::KbA)
      self.view = :game
    elsif view == :game
      paddle.x_coordinate = mouse_x
    end
  end
```
Then we want to draw the paddle
```ruby
  def draw
    if view == :menu
      draw_menu
    elsif view == :game
      paddle.draw
    end
  end
```
Now that we know what we expect the class to do, we can go ahead and define the class.
Let's create a new file for this class definition.

`$ touch paddle.rb`

And also require it in our `game.rb` file.

`require_relative 'paddle'`

This paddle will have four attributes:

1. x_coordinate
2. y_coordinate
3. z_coordinate
4. image which is an instance of [Gosu::Image](https://www.libgosu.org/rdoc/Gosu/Image.html) and is initialized with the source of the image file.

This paddle object will have to have a `#draw` method which will just call the `#draw` method on the image object with the paddles coordinates.

```ruby
class Paddle
  attr_accessor :x_coordinate, :y_coordinate, :z_coordinate, :image

  def initialize(x_coordinate, y_coordinate, z_coordinate)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
    @z_coordinate = z_coordinate
    @image = Gosu::Image.new('images/paddle.png')
  end

  def draw
    image.draw(image_x_coordinate, y_coordinate, z_coordinate)
  end

  def image_x_coordinate
    x_coordinate - image_width / 2
  end

  def image_width
    image.width
  end
end
```

I have adjusted the x-coordinate of the image, so the x-coordinate of the object corresponds to the center of the image when it is drawn.

Also we need to create a folder that will store all our images, and include the [image](https://raw.githubusercontent.com/davidrf/introduction_to_gosu/master/images/paddle.png) of the paddle there.

`$ mkdir images`

## Create A Ball

Next we will create a ball that moves up the screen. We will initialize the ball with its initial coordinates.

```ruby
  attr_accessor :view, :paddle, :ball
  attr_reader :menu_font

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT)
    @view = :menu
    @menu_font = Gosu::Font.new(FONT_HEIGHT_MEDIUM)
    @paddle = Paddle.new(SCREEN_WIDTH / 2, 800, 0)
    @ball = Ball.new(SCREEN_WIDTH / 2, 600, 0)
  end
```

We will want to update the ball's position based on how much time has passed.
```ruby
  def update
    if view == :menu && button_down?(Gosu::KbA)
      self.view = :game
    elsif view == :game
      paddle.x_coordinate = mouse_x
      ball.update_position(time_elapsed)
    end
  end
```
We have to define the `#time_elapsed` method ourselves. We can get the number of milliseconds that have elapsed since
the game was started by using `Gosu.milliseconds`. If we store the value in a variable and then call Gosu.milliseconds again, then
the time elapsed is the difference between the latest Gosu.milliseconds return value and the value stored in a variable. The following code implements
this method.
```ruby
  attr_accessor :view, :paddle, :ball, :previous_time
  attr_reader :menu_font

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT)
    @view = :menu
    @menu_font = Gosu::Font.new(FONT_HEIGHT_MEDIUM)
    @paddle = Paddle.new(SCREEN_WIDTH / 2, 800, 0)
    @ball = Ball.new(SCREEN_WIDTH / 2, 600, 0)
    @previous_time = Gosu.milliseconds
  end

  def time_elapsed
    current_time = Gosu.milliseconds
    time_elapsed = current_time - previous_time
    self.previous_time = current_time
    time_elapsed
  end
```
We also need to draw the ball in a similar way that we drew the paddle.
```ruby
  def draw
    if view == :menu
      draw_menu
    elsif view == :game
      paddle.draw
      ball.draw
    end
  end
```
Now it is time to implement the Ball class. First create the file.

`$ touch ball.rb`

Require the file in your `game.rb` file

`require_relative 'ball'`

Add the (ball image)[https://raw.githubusercontent.com/davidrf/introduction_to_gosu/master/images/ball.gif] to your images folder.

The Ball class is very similar to the paddle class, but it will also have velocity attributes.
The `#update_position` method will utilize these velocities to recalculate the position of the ball.

```ruby
class Ball
  attr_accessor :x_coordinate, :y_coordinate, :z_coordinate,
                :velocity_x, :velocity_y, :image

  def initialize(x_coordinate, y_coordinate, z_coordinate)
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
    @z_coordinate = z_coordinate
    @velocity_x = 0
    @velocity_y = -0.1
    @image = Gosu::Image.new("images/ball.gif")
  end

  def update_position(time_elapsed)
    self.x_coordinate = x_coordinate + velocity_x * time_elapsed
    self.y_coordinate = y_coordinate + velocity_y * time_elapsed
  end

  def draw
    image.draw(image_x_coordinate, image_y_coordinate, z_coordinate)
  end

  def image_width
    image.width
  end

  def image_height
    image.height
  end

  def image_x_coordinate
    x_coordinate - image_width / 2
  end

  def image_y_coordinate
    y_coordinate - image_height / 2
  end
end
```
This concludes the Gosu Tutorial. You should now know enough of the framework to start creating your own games! Have fun!


