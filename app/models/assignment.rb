# frozen_string_literal: true

class Assignment < ApplicationRecord
  belongs_to :list
  belongs_to :article
  validates :list_id, presence: true
  validates :article_id, presence: true
  validates :rank, presence: true
end

def Assignment.insert_article(params)
  latest_article = Assignment.where(list_id: params[:selected_list]).order(rank: :desc).first
  new_rank = if latest_article.nil?
               1
             else
               latest_article.rank + 1
             end

  !Assignment.create(list_id: params[:selected_list], article_id: params[:article_id], rank: new_rank).id.nil?
end
