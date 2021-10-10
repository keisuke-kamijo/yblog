# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggings
  has_many :articles, through: :taggings
  validates :name, presence: true, length: { maximum: 20 }
end
