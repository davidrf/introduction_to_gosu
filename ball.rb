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
