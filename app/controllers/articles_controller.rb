# frozen_string_literal: true

class ArticlesController < ApplicationController
  def new
    @article = Article.new
    @tag = @article.tags.new
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.is_visible = true

    tag_names = params[:article][:tags][:name].split

    logger.debug(pp(@tag))
    @tagging = Tagging.new

    is_succeed_to_save = true 

    ActiveRecord::Base.transaction do
      @article.save!

      tag_names.each do |tag_name|
        registered_tag = Tag.find_by(name: tag_name)

        if registered_tag
          @tag = registered_tag
        else
          @tag = Tag.new
          @tag.name = tag_name
          @tag.save!
        end
        
        @tagging = Tagging.new
        @tagging.tag_id = @tag.id
        @tagging.article_id = @article.id
        @tagging.save! 
      end
    rescue ActiveRecord::RecordInvalid
      render '/login'
    end

    flash[:success] = "投稿が完了しました"
    #redirect_to root_url
  end

  private
    def article_params
      params.require(:article).permit(:title, :tags, :body)
    end
end
