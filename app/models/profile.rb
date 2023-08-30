class Profile < ApplicationRecord
  belongs_to :user
  attr_accessor :nickname, :image

end
