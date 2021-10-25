# frozen_string_literal: true

class List < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :is_placed, inclusion: { in: [true, false] }
end
