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

  def show
    @article = Article.find(params[:id])
    @tags = @article.tags
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

  private

  def article_params
    params.require(:article).permit(:id, :title, :body)
  end
end
