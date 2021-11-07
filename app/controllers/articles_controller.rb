# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :logged_in_user, only: %i[new create edit update]
  before_action :correct_user,   only: %i[edit update]

  def new
    @article = Article.new
    @tag = @article.tags.new
  end

  def create
    tag_names = params[:article][:tags][:name].split
    if Article.save_with_tags(current_user, tag_names, article_params)
      flash[:success] = '投稿が完了しました'
      redirect_to "/users/#{current_user.id}/articles"
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
    @tags = @article.tags

    @lists = List.where(user_id: @article.user_id) if owner_of_article?(@article.id)
  end

  def edit
    @article = Article.find(params[:id])
    @tags = @article.tags
    @tags_value = ''
    @tags.each do |tag|
      @tags_value = +@tags_value << tag.name << ' '
    end
  end

  def update
    tag_names = params[:article][:tags][:name].split
    article_id = params[:article][:id]
    article = Article.find(article_id)

    if article.update_with_tags(tag_names, article_params)
      flash[:success] = '記事が更新されました'
      redirect_to article_url(article_id)
    else
      render 'edit'
    end
  end

  def destroy
    article = Article.find(params[:id])
    user_id = article.user_id
    article.destroy
    flash[:success] = '記事を削除しました。'
    redirect_to "/users/#{user_id}/articles"
  end

  def insert
    if Assignment.insert_article(selected_list_params)
      flash[:success] = 'この記事をリストに追加しました。'
    else
      flash[:danger] = 'リストの更新に失敗しました。'
    end

    redirect_to article_url(params[:article_id])
  end

  private

  def article_params
    params.require(:article).permit(:id, :title, :body)
  end

  def selected_list_params
    params.permit(:article_id, :id, :selected_list)
  end

  def logged_in_user
    store_location
    return if logged_in?

    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end

  def correct_user
    user_id = Article.find(params[:id]).user_id
    @user = User.find(user_id)
    redirect_to(root_url) unless @user == current_user
  end
end
