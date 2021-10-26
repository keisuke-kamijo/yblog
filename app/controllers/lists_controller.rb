# frozen_string_literal: true

class ListsController < ApplicationController
  def create
    @list = List.new(list_params)
    if @list.save
      flash[:success] = 'リストを追加しました。'
    else
      flash[:danger] = '保存に失敗しました。'
    end
    redirect_back fallback_location: login_path
  end

  private

  def list_params
    params.require(:list).permit(:name, :is_placed, :user_id)
  end
end
