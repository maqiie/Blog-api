# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :posts
  has_many :post_likes
  has_one :profile, dependent: :destroy
  has_one :profile


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  enum role: [:user, :admin] # Define roles as enum
end
