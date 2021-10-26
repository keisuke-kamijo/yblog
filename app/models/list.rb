# frozen_string_literal: true

class List < ApplicationRecord
  belongs_to :user
  has_many :assignments, dependent: :destroy
  has_many :articles, through: :assignments
  validates :name, presence: true, length: { maximum: 50 }
  validates :is_placed, inclusion: { in: [true, false] }
  validates :user_id, presence: true
end
