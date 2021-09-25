# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.references :user
      t.string :title
      t.text :body
      t.boolean :is_visible

      t.timestamps
    end
  end
end
