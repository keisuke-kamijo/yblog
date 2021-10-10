class ArticlesController < ApplicationController
  def new
    @article = Article.new
    @tag = @article.tags.new
  end

  def create
  end
end
