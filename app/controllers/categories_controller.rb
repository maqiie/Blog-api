# app/controllers/categories_controller.rb

class CategoriesController < ApplicationController
  def posts
    category = Category.find(params[:id])
    posts = category.posts
    render json: posts
  end

  def index
    categories = Category.all
    render json: categories
  end
end
