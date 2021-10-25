# frozen_string_literal: true

class Assignment < ApplicationRecord
  belongs_to :list
  belongs_to :article
  validates :list_id, presence: true
  validates :article_id, presence: true
  validates :rank, presence: true
end
