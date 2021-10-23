# frozen_string_literal: true

class Article < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 1000 }
  validates :is_visible, inclusion: { in: [true, false] }

  def self.save_with_tags(current_user, tag_names, article_params)
    @article = current_user.articles.build(article_params)
    @article.is_visible = true
    @tagging = Tagging.new

    ActiveRecord::Base.transaction do
      @article.save!

      tag_names.each do |tag_name|
        tag_id = Tag.get_or_create(tag_name)
        Tagging.create!(tag_id: tag_id, article_id: @article.id)
      end
    rescue ActiveRecord::RecordInvalid
      return false
    end
    true
  end

  def update_with_tags(tag_names, article_params)
    ActiveRecord::Base.transaction do
      Tagging.destroy_by(article_id: article_params[:id])
      self.update!(article_params)
      tag_names.each do |tag_name|
        tag_id = Tag.get_or_create(tag_name)
        Tagging.create!(tag_id: tag_id, article_id: article_params[:id])
      end
    rescue ActiveRecord::RecordInvalid
      return false
    end
    true
  end
end
