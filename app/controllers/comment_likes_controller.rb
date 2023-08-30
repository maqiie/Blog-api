class CommentLikesController < ApplicationController
    before_action :authenticate_user!
  
    def like
      comment = Comment.find(params[:comment_id])
      comment_like = comment.comment_likes.create(user: current_user)
      if comment_like.persisted?
        render json: { message: 'Comment liked successfully' }
      else
        render json: { message: 'Error liking comment' }, status: :unprocessable_entity
      end
    end
  
    def dislike
      comment = Comment.find(params[:comment_id])
      like = comment.comment_likes.find_by(user: current_user)
      like.destroy if like
      render json: { message: 'Comment disliked successfully' }
    end
  end
  