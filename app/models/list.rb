# frozen_string_literal: true

class List < ApplicationRecord
  belongs_to :user
  has_many :assignments, dependent: :destroy
  has_many :articles, through: :assignments
  validates :name, presence: true, length: { maximum: 50 }
  validates :is_placed, inclusion: { in: [true, false] }
  validates :user_id, presence: true

  def self.update_with_rank(list_id, rank)
    list_assignments = Assignment.where(list_id: list_id)

    new_rank = 1
    ActiveRecord::Base.transaction do
      rank.each do |article_id|
        assignment = list_assignments.find_by(article_id: article_id.to_i)
        assignment.update(rank: new_rank)
        new_rank += 1
      end
    rescue ActiveRecord::RecordInvalid
      return false
    end
    true
  end
end
