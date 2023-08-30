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
  end
  