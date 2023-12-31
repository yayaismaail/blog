# frozen_string_literal: true

# Top-level documentation comment for CreatePosts module
class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.references :author, null: false, foreign_key: { to_table: 'users' }, index: true
      t.integer :comments_counter
      t.integer :likes_counter

      t.timestamps
    end
  end
end
