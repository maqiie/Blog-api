class CommentsController < ApplicationController
    before_action :authenticate_user!
    
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user
  
      if @comment.save
        redirect_to @post, notice: 'Comment was successfully created.'
      else
        redirect_to @post, alert: 'Error creating comment.'
      end
    end
    def index
        @post = Post.find(params[:post_id])
        @comments = @post.comments
        render json: @comments
      end

      
   
    def destroy
      @comment = Comment.find(params[:id])
      
      if @comment
        @comment.destroy
        redirect_to @comment.post, notice: 'Comment was successfully deleted.'
      else
        redirect_to root_path, alert: 'Unable to delete comment.'
      end
    end
    

    private
  
    def comment_params
      params.require(:comment).permit(:content, :comment)
    end
    
  end
  