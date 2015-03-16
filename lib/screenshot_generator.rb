require 'lib/screenshot'

class ScreenshotGenerator < ::Middleman::Extension
  include Capybara::DSL

  def initialize(app, options_hash={}, &block)
    super
    app.before_build do |builder|
      Screenshot.prepare

      themes.each do |theme|
        Screenshot.new(theme).generate_theme_image
      end

      puts "Hello World"
      # builder.run './my_deploy_script.sh'
    end
  end
end

::Middleman::Extensions.register(:screenshot_generator, ScreenshotGenerator)