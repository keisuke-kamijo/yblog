# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggings
  validates :name, presence: true, length: { maximum: 20 }
end
