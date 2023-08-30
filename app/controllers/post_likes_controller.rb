class PostLikesController < ApplicationController
  before_action :authenticate_user!

  def like
    post = Post.find(params[:post_id])
    post_like = post.post_likes.create(user: current_user)
    if post_like.persisted?
      render json: { message: 'Post liked successfully' }
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
