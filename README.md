# Introduction To Gosu
## Getting Started
We first have to create a file which starts up the game when run.

`$ touch game.rb`

In this file, we need to do three things:

1. require the Gosu framework
2. instantiate a `GameWindow` object with a screen width and screen height (in pixels).
3. run the `#show` method on this `GameWindow` object.

```ruby
require 'gosu'

screen_width = 600
screen_height = 900
game_window = GameWindow.new(600, 900)
game_window.show
```
