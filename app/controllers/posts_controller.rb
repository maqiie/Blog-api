
class PostsController < ApplicationController
         before_action :authenticate_user!, except: [:index, :show, :likes]
  

    def index
      @posts = Post.all
  
      respond_to do |format|
        format.json do
          # Create an array to store the JSON representation of each post
          posts_data = []
          @posts.each do |post|
            post_data = post.as_json
            if post.image.attached?
              post_data["image_url"] = rails_blob_path(post.image, only_path: true)
            end
            posts_data << post_data
          end
          render json: posts_data
        end
      end
    end
    
    def category_posts
      category = Category.find(params[:category_id])
      posts = category.posts
  
      render json: posts
    end
  
    def user_posts
      @user = User.find(params[:user_id])
      @posts = @user.posts
      render json: @posts
    end

    def show
      @post = Post.find(params[:id])
  
      respond_to do |format|
        format.html # This is for the HTML format (not needed if you're building a single-page app)
        format.json do
          # Include the image URL in the JSON response
          post_data = @post.as_json
          if @post.image.attached?
            post_data["image_url"] = rails_blob_path(@post.image, only_path: true)
          end
          render json: post_data
        end
      end
    end
    
  
    def new
      @post = Post.new
    end
   
    def create
      @post = current_user.posts.build(post_params)
    
      if @post.save
        # Handle image attachments if they are present
        if params[:post][:images].present?
          params[:post][:images].each do |image|
            @post.image.attach(image)
          end
        end
    
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
      end
    end
    
  
    
    def edit
      @post = current_user.posts.find(params[:id])
    end
  
    def update
      @post = current_user.posts.find(params[:id])
  
      if @post.update(post_params)
        redirect_to @post, notice: 'Post was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @post = current_user.posts.find(params[:id])
      @post.destroy
      redirect_to posts_url, notice: 'Post was successfully destroyed.'
    end
    def likes
      post = Post.find(params[:id])
      likes_count = post.post_likes.count
  
      render json: {
        likesCount: likes_count
      }
    end
  
    def dislikes
      post = Post.find(params[:id])
      dislikes_count = post.dislikes_count
  
      render json: {
        dislikesCount: dislikes_count
      }
    end
  
    




      private

def post_params
  params.require(:post).permit(:title, :content, :category_id, :images)
end

  end
  