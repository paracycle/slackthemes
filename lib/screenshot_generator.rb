require 'lib/screenshot'

class ScreenshotGenerator < ::Middleman::Extension
  include Capybara::DSL

  def initialize(app, options_hash={}, &block)
    super
    app.before_build do
      Screenshot.prepare

      themes.each do |theme|
        Screenshot.new(theme).generate_theme_image
      end
    end
  end
end

::Middleman::Extensions.register(:screenshot_generator, ScreenshotGenerator)