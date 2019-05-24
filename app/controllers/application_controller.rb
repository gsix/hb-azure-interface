class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: %i(home)

  def home
    usage_mark = File.read Rails.root.join('app', 'views', 'application', 'usage.md')
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    @rendered_usage = Redcarpet::Markdown.new(renderer, {}).render(usage_mark)
  end
end
