require 'middleman'
require 'capybara'
require 'capybara/poltergeist'
require 'mini_magick'

class Screenshot
  include Capybara::DSL
  attr_accessor :theme, :theme_name

  def self.prepare
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, window_size: [1280, 768])
    end
    Capybara.default_driver = :poltergeist
    Capybara.app = ::Middleman::Application.server.inst do
      set :root, File.expand_path(File.join(File.dirname(__FILE__), '..'))
      set :environment, :development
      set :show_exceptions, false
    end
  end

  def initialize(theme_name)
    @theme_name = theme_name
    @theme = theme_name.parameterize.underscore
  end

  def generate_theme_image
    puts "Generating image for theme #{theme_name}"
    visit '/'
    within ".theme_#{theme}" do
      choose 'sidebar_theme_rd'
    end
    sleep 1
    file = Tempfile.new([theme, ".png"])
    begin
      page.save_screenshot(file.path, full: true)

      MiniMagick::Tool::Convert.new do |convert|
        convert << file.path
        convert.crop '220x220+0+0'
        convert << "source/images/theme/#{theme}.png"
      end
    ensure
      file.close
      file.unlink
    end
  end
end