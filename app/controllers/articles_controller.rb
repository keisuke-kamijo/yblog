# frozen_string_literal: true

class ArticlesController < ApplicationController
  def new
    @article = Article.new
    @tag = @article.tags.new
  end

  def create
    tag_names = params[:article][:tags][:name].split
    if Article.save_with_tags(current_user, tag_names, article_params)
      flash[:success] = '投稿が完了しました'
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
