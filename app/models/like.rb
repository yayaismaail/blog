# frozen_string_literal: true

# Top-level documentation comment for Like module
class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :update_post_likes_counter
  after_destroy :update_post_likes_counter

  def update_post_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
