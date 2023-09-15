# # app/controllers/categories_controller.rb

# class CategoriesController < ApplicationController
#   def posts
#     category = Category.find(params[:id])
#     posts = category.posts
#     render json: posts
#   end

#   def index
#     categories = Category.all
#     render json: categories
#   end
# end
class CategoriesController < ApplicationController
  def posts
    category_name = params[:name] # Change to :name to accept category names
    category = Category.find_by(name: category_name) # Find the category by name

    if category
      posts = category.posts
      render json: posts
    else
      render json: { error: 'Category not found' }, status: :not_found
    end
  end
  def posts_by_name
    category_name = params[:name]
    category = Category.find_by(name: category_name)
  
    if category
      posts = category.posts
      render json: posts
    else
      render json: { error: 'Category not found' }, status: :not_found
    end
  end
  def show
    category = Category.find_by(name: params[:name]) # Find the category by name
    @posts = category.posts # Retrieve the posts associated with the category
  end

  def index
    categories = Category.includes(:posts) # Load categories and their associated posts
    render json: categories.to_json(include: :posts)
  end
end
