# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 1000 }
  validates :is_visible, inclusion: { in: [true, false] }
end
