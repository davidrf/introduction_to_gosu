# Introduction To Gosu
## Getting Started
We first have to create a file which starts up the game when run.
`$ touch game.rb`
In this file, we need to do three things:
1. require the Gosu framework
2. instantiate a `GameWindow` object with a screen width and screen height.
3. run the `#show` method on this `GameWindow` object.
```ruby
game_window = GameWindow.new
```
