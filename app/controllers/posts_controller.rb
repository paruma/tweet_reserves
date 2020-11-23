require "oembed"
OEmbed::Providers.register_all

class PostsController < ApplicationController
  def index
    @posts = Post.all
    OEmbed::Providers.register_all
    embed_json = OEmbed::Providers.get('http://www.youtube.com/watch?v=2BYXBC8WQ5k')
    if embed_json
      @twitter_html = embed_json.html.html_safe
    end
    
  end

  def new
    @url = params[:url]
    begin
      if @url
        embed_json = OEmbed::Providers.get(@url)
        if embed_json
          @embed = embed_json.html.html_safe
        end
      end
    rescue => error
      @error_msg = "URLが間違っています。"
    end
  end
end
