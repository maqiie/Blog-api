class CommentLikesController < ApplicationController
    before_action :authenticate_user!

   
    def show
      post_id = params[:post_id]
      comment_id = params[:comment_id]
      
      # Retrieve the likes count for the specified comment
      likes_count = CommentLike.where(comment_id: comment_id).count
      
      # You can customize the JSON response structure as needed
      response_data = { likesCount: likes_count }
      
      respond_to do |format|
        format.html { render body: nil, status: :not_acceptable }
        format.json { render json: response_data }
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
  