class CommentLikesController < ApplicationController
    before_action :authenticate_user!

    def show
      # Fetch the comment likes data based on the post_id and comment_id
      post_id = params[:post_id]
      comment_id = params[:comment_id]
      
      # Fetch comment likes data here based on post_id and comment_id
      @comment_likes = CommentLike.where(post_id: post_id, comment_id: comment_id)
  
      # Respond with JSON data
      respond_to do |format|
        format.json { render json: @comment_likes }
      end
    end
  
  
    def like
      ActiveRecord::Base.transaction do
      comment = Comment.find(params[:comment_id])
      comment_like = comment.comment_likes.create(user: current_user)
      if comment_like.persisted?
        render json: { message: 'Comment liked successfully' }
      else
        render json: { message: 'Error liking comment' }, status: :unprocessable_entity
      end
    end
    end
  
    def dislike
      comment = Comment.find(params[:comment_id])
      like = comment.comment_likes.find_by(user: current_user)
      like.destroy if like
      render json: { message: 'Comment disliked successfully' }
    end
  end
  