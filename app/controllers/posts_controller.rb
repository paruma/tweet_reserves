require "oembed"

class PostsController < ApplicationController
  def index
    @posts = Post.all
    OEmbed::Providers.register_all
    @twitter_html = OEmbed::Providers.get('http://www.youtube.com/watch?v=2BYXBC8WQ5k').html.html_safe
  end
end
