require 'slim'
###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
ignore 'blog'
ignore 'stylesheets/libs/*'

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###
activate :syntax

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  blog.permalink = '{year}-{month}-{day}.html'
  # Matcher for blog source files
  blog.sources = '{year}-{month}-{day}.html'
  # blog.taglink = 'tags/{tag}.html'
  blog.layout = 'blog'
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = '{year}.html'
  # blog.month_link = '{year}/{month}.html'
  # blog.day_link = '{year}/{month}/{day}.html'
  # blog.default_extension = '.markdown'
  # blog.summary_generator = proc { |text| p text.summary }

  blog.tag_template = 'tag.html'
  blog.calendar_template = 'calendar.html'

  # Enable pagination
  blog.paginate = true
  blog.per_page = 100
  # blog.page_link = "page/{num}"
end

set :markdown_engine, :redcarpet
set :markdown, tables: true, autolink: true, no_intra_emphasis: true, fenced_code_blocks: true, space_after_headers: true

page '/feed.xml', layout: false

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
helpers do
  def article_path(article)
    "/#{article.date.strftime '%F'}.html"
  end
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end

before_build do
  FileUtils.rm_r Dir.glob('../*')
end
after_build do
  FileUtils.mv Dir.glob('./build/*'), '../'
end
