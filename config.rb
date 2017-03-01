require 'lib/helpers'
require 'slim'

###
## Blog settings
###

set :markdown_engine, :redcarpet
set :slim, :layout_engine => :slim

activate :blog do |blog|
    blog.prefix = "blog"
    blog.permalink = "{title}.html"
    blog.summary_separator = /\(READMORE\)/
end

activate :directory_indexes
activate :inliner
activate :sprockets

configure :build do
  activate :minify_css
  activate :minify_javascript
end

###
## Other settings
####

helpers Helpers

set :css_dir, 'css'
set :js_dir, 'javascripts'
set :images_dir, 'images'

