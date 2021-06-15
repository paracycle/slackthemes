require 'colorist'

module ColorHelpers
  include Colorist

  def mix(color1, color2, ratio)
    color1 = Color.from(color1)
    color2 = Color.from(color2)
    (color1 * (1 - ratio) + color2 * ratio).to_s(:css_rgb)
  end

  def rgb(color)
    Color.from(color).to_s(:css_rgb)
  end

  def rgba(color, alpha)
    Color.from(color).tap { |c| c.a = alpha }.to_s(:css_rgba)
  end
end