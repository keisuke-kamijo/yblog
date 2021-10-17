# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @num_of_articles = Article.where(user_id: params[:id]).size
    @tags = Set.new
    @user.articles.each do |article|
      article.tags.each do |tag|
        @tags.add(tag)
      end
    end
  end

  def articles
    @articles = Article.where(user_id: params[:id]).includes(taggings: :tag)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
