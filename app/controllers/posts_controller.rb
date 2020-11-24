require "oembed"
OEmbed::Providers.register_all

class PostsController < ApplicationController
  def index
    @tweet_sender = params[:tweet_sender]
    if @tweet_sender
      @posts = Post.where(tweet_sender: @tweet_sender)
    else
      @posts = Post.all
    end
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

  def match_user(url)
    result = url.match(/twitter.com\/(.+)\/status/)
    if result.length >= 2
      return result[1]
    end
    return ""
  end

  def create
    @url = params[:url_form]
    @comment = params[:comment]
    tweet_sender = match_user(@url)
    @post = Post.new(
      comment: @comment,
      url: @url,
      tweet_sender: tweet_sender
    )
    if @post.save
       redirect_to("/posts/index")
       flash[:success] = "投稿に成功しました"
    else
       render("/posts/new")
    end
  end

  def edit
  end

  def update
  end
end
