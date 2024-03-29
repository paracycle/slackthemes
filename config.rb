require 'ostruct'
require 'dotenv'
require 'lib/theme'
require 'lib/color_helpers'
Dotenv.load

# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers ColorHelpers
helpers do
  def themes
    data.themes.sort_by { |theme| theme['name'].downcase }.map do |theme|
      Theme.new(name: theme['name'], colors: theme['colors'])
    end
  end

  def default_theme
    theme = data.themes.first
    Theme.new(name: theme['name'], colors: theme['colors'])
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Build-specific configuration
configure :build do
  # activate :screenshot_generator

  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
