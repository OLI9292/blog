require 'lib/helpers'
require 'ansi/code'
require 'slim'

###
## Blog settings
###

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, disable_indented_code_blocks: true, strikethrough: true, smartypants: true, with_toc_data: true
set :slim, :layout_engine => :slim

activate :blog do |blog|
  blog.prefix = "blog"
  blog.permalink = "{title}.html"
  blog.summary_separator = /\(READMORE\)/
	blog.layout = "partials/_blog_post"
end

activate :directory_indexes
activate :inliner
activate :syntax
activate :sprockets

helpers Helpers

set :css_dir, 'css'
set :js_dir, 'javascripts'
set :images_dir, 'images'
