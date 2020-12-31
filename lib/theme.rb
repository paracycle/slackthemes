require 'json'

class Theme
  attr_reader :name
  attr_reader :slug,  :digest
  attr_reader :column_bg,  :menu_bg,  :active_item,  :active_item_text
  attr_reader :hover_item,  :text_color,  :active_presence,  :mention_badge
  attr_reader :top_nav_bg, :top_nav_text

  def initialize(name:, colors:)
    @name = name
    color_values = colors.split(',')
    @slug = name.parameterize.underscore
    @digest = Digest::MD5.new.hexdigest(colors)
    @column_bg = color_values[0]
    @menu_bg = color_values[1]
    @active_item = color_values[2]
    @active_item_text = color_values[3]
    @hover_item = color_values[4]
    @text_color = color_values[5]
    @active_presence = color_values[6]
    @mention_badge = color_values[7]
    @top_nav_bg = color_values[8] || @menu_bg
    @top_nav_text = color_values[9] || @text_color
  end

  def colors
    {
      column_bg: column_bg,
      menu_bg: menu_bg,
      active_item: active_item,
      active_item_text: active_item_text,
      hover_item: hover_item,
      text_color: text_color,
      active_presence: active_presence,
      mention_badge: mention_badge,
      top_nav_bg: top_nav_bg,
      top_nav_text: top_nav_text,
  }.to_json
  end
  # def calculate_top_nav_bg
  #   text_color = RGB::Color.from_rgb_hex(@text_color)
  #   column_bg =  RGB::Color.from_rgb_hex(@column_bg)
  #   text_color.mix(column_bg, 25)
  # end

  # def calculate_top_nav_text
  #   Math.min(Math.max(e - t, 0), 255)
  # end
end
