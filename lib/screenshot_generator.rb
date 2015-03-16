require 'lib/screenshot'

class ScreenshotGenerator < ::Middleman::Extension
  include Capybara::DSL

  def initialize(app, options_hash={}, &block)
    super
    app.before_build do |builder|
      builder.say "==> Begin - Theme thumbnail generator", :green
      Screenshot.prepare

      themes.each do |theme|
        Screenshot.new(theme).generate_theme_image(builder)
      end
      builder.say "==> End   - Theme thumbnail generator", :green
    end
  end
end

::Middleman::Extensions.register(:screenshot_generator, ScreenshotGenerator)