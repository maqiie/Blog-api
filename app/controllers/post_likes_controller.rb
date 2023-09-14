class PostLikesController < ApplicationController
   before_action :authenticate_user!

# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  def index
    post = Post.find(params[:post_id])
    likes = post.likes
    render json: likes
  end
end

  def like
    post = Post.find(params[:post_id])
    post_like = post.post_likes.create(user: current_user)
    
    if post_like.persisted?
      like_count = post.post_likes.count
      render json: { message: 'Post liked successfully', like_count: like_count }
    else
      render json: { message: 'Error liking post' }, status: :unprocessable_entity
    end
  end
  

  def dislike
    post = Post.find(params[:post_id])
    like = post.post_likes.find_by(user: current_user)
    like.destroy if like
    render json: { message: 'Post disliked successfully' }
  end
end
# class PostLikesController < ApplicationController
#   before_action :authenticate_user!

#   def like
#     post = Post.find(params[:post_id])
#     post_like = post.post_likes.create(user: current_user)
#     if post_like.persisted?
#       likes_count = post.post_likes.count
#       dislikes_count = post.dislikes_count # Assuming you have a similar method for dislikes count
#       render json: {
#         message: 'Post liked successfully',
#         likes_count: likes_count,
#         dislikes_count: dislikes_count
#       }
#     else
#       render json: { message: 'Error liking post' }, status: :unprocessable_entity
#     end
#   end

#   def dislike
#     post = Post.find(params[:post_id])
#     like = post.post_likes.find_by(user: current_user)
#     like.destroy if like
#     likes_count = post.post_likes.count
#     dislikes_count = post.dislikes_count # Assuming you have a similar method for dislikes count
#     render json: {
#       message: 'Post disliked successfully',
#       likes_count: likes_count,
#       dislikes_count: dislikes_count
#     }
#   end
# end
