class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    belongs_to :category
    has_many :comments, dependent: :destroy
    has_many :post_likes


    def thumbnail
      if image.attached?
        image.variant(resize: '100x100').processed
      end
    end


    def dislikes_count
      # Define the logic to calculate dislikes count here
    end

    def likes_count
      # Assuming you have a relationship between posts and likes, e.g., has_many :post_likes
      # Count the number of post likes associated with this post.
      post_likes.count
    end
  end
  