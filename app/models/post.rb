# Top-level documentation comment for Post module
class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', counter_cache: true
  has_many :comments
  has_many :likes

  after_create :update_user_counters
  after_destroy :update_user_counters

  def update_user_counters
    author.update(posts_counter: author.posts.count)
    update(comments_counter: comments.count, likes_counter: likes.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
