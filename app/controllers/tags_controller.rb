class TagsController < ApplicationController
  #protect_from_forgery with: :null_session
  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(name: params[:name_form])
    if @tag.save
      flash[:success] = "タグの作成に成功しました"
      redirect_to("/tags/index")
    else
      flash[:warning] = "タグの作成に失敗しました"
      render("tags/new")
    end
  end
  
  def edit
    @tag = Tag.find_by(id: params[:id])
  end

  def update
    @tag = Tag.find_by(id: params[:id])
    @tag.name = params[:name_form]
    if @tag.save
      flash[:success] = "タグの編集に成功しました"
      redirect_to("/tags/index")
    else
      flash[:warning] = "タグの編集に失敗しました"
      render("tags/edit")
    end
  end

  def destroy
    @tag = Tag.find_by(id: params[:id])
    @tag.destroy
    flash[:success] = "タグ\"#{@tag.name}\"を削除しました"
    redirect_to("/tags/index")
  end
end
