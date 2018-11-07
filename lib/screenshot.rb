require 'middleman'
require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'mini_magick'

class Screenshot
  include Capybara::DSL
  attr_accessor :theme

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

  def initialize(theme)
    @theme = theme
  end

  def generate_theme_image(builder)
    if File.exist? target_file
      builder.say_status :exists, target_file, :blue
      return
    end

    builder.say_status :generating, target_file, :green

    visit '/'
    within ".theme_#{theme.slug}" do
      choose 'sidebar_theme_rd'
    end
    sleep 1

    create_thumbnail do |path|
      page.save_screenshot(path, full: true)
    end
  end

  def create_thumbnail
    file = Tempfile.new([theme.slug, ".png"])
    yield(file.path)
    MiniMagick::Tool::Convert.new do |convert|
      convert << file.path
      convert.crop '220x220+0+0'
      convert << target_file
    end
  ensure
    file.close
    file.unlink
  end

  def target_file
    "source/images/theme/#{theme.slug}-#{theme.digest}.png"
  end
end
