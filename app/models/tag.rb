# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggings
  has_many :articles, through: :taggings
  validates :name, presence: true, length: { maximum: 20 }

  def self.get_or_create(name)
    registered_tag = Tag.find_by(name: name)

    if registered_tag
      registered_tag.id
    else
      @tag = Tag.new
      @tag.name = tag_name
      @tag.save!
      @tag.id
    end
  end
end
