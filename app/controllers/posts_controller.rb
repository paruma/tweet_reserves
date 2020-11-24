require "oembed"
OEmbed::Providers.register_all

class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  end


  def preview
    url = params[:url]
    begin
      if url
        embed_json = OEmbed::Providers.get(url)
        if embed_json
          embed = embed_json.html.html_safe
        end
      end
    rescue => error
      error_msg = "URLが間違っています。"
    end
    render :json => { embed: embed, error_msg: error_msg}
  end



  def create
    @url = params[:url_form]
    @comment = params[:comment]
    @post = Post.new(
      comment: @comment,
      url: @url
    )
    if @post.save
       redirect_to("/posts/index")
       flash[:success] = "投稿に成功しました"
    else
       render("/posts/new")
    end

  end
end
