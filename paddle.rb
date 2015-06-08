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
