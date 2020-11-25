require "oembed"
OEmbed::Providers.register_all

class PostsController < ApplicationController
  def index
    @tweet_sender = params[:tweet_sender]
    @id = params[:id]
    if @id
      @posts = Post.where(id: @id)
    elsif @tweet_sender
      @posts = Post.where(tweet_sender: @tweet_sender)
    else
      @posts = Post.all
    end
    @posts = @posts.order(updated_at: :desc)
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
    if result && result.length >= 2
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
       flash[:success] = "投稿に成功しました"
       redirect_to("/posts/index")
    else
       render("/posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.url = params[:url_form]
    @post.comment = params[:comment]
    @post.tweet_sender = match_user(@post.url)
    if @post.save
      flash[:success] = "編集に成功しました"
      redirect_to("/posts/index")
      else
       render("/posts/new")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:success] = "削除しました"
    redirect_to("/posts/index")
  end
end
