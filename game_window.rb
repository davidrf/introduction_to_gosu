class GameWindow < Gosu::Window
  SCREEN_WIDTH = 600
  SCREEN_HEIGHT = 900
  FONT_HEIGHT_MEDIUM = 50

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

  def update
    if view == :menu && button_down?(Gosu::KbA)
      self.view = :game
    elsif view == :game
      paddle.x_coordinate = mouse_x
      ball.update_position(time_elapsed)
    end
  end

  def draw
    if view == :menu
      draw_menu
    elsif view == :game
      paddle.draw
      ball.draw
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

  def time_elapsed
    current_time = Gosu.milliseconds
    time_elapsed = current_time - previous_time
    self.previous_time = current_time
    time_elapsed
  end
end
