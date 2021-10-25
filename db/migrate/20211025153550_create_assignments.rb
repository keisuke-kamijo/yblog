class CreateAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :assignments do |t|
      t.references :list, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true
      t.integer :rank

      t.timestamps
    end
  end
end
