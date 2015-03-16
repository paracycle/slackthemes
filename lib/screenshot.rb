require 'middleman'
require 'capybara'
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
    @theme = OpenStruct.new(theme.merge(
      slug: theme[:name].parameterize.underscore,
      digest: Digest::MD5.new.hexdigest(theme[:colors])
    ))
  end

  def generate_theme_image
    if File.exist? target_file
      puts "Image for theme #{theme.name} already exists"
      return
    end

    puts "Generating image for theme #{theme.name}"
    visit '/'
    within ".theme_#{theme.slug}" do
      choose 'sidebar_theme_rd'
    end
    sleep 1

    file = Tempfile.new([theme.slug, ".png"])
    begin
      page.save_screenshot(file.path, full: true)

      MiniMagick::Tool::Convert.new do |convert|
        convert << file.path
        convert.crop '220x220+0+0'
        convert << target_file
      end
    ensure
      file.close
      file.unlink
    end
  end

  def target_file
    "source/images/theme/#{theme.slug}-#{theme.digest}.png"
  end
end