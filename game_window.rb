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
