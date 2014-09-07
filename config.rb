Time.zone = "Tokyo"

activate :blog do |blog|
  blog.permalink = "article/{year}/{month}/{day}/{title}.html"

  blog.sources = "article/{year}-{month}-{day}-{title}.html"
  blog.default_extension = '.md'

  blog.layout = "layout"

  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250

  blog.taglink = "tags/{tag}.html"
  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"
end

page "/feed.xml", layout: false

set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'images'

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :autolink => true, :smartypants => true

activate :syntax
activate :livereload
