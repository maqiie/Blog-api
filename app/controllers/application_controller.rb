class ApplicationController < ActionController::Base
        #  before_action :authenticate_user!, except: [:create]

        skip_before_action :verify_authenticity_token

        include DeviseTokenAuth::Concerns::SetUserByToken

        rescue_from CanCan::AccessDenied do |exception|
                redirect_to root_path, alert: "Access denied."
              end


              after_action :set_cors_headers

  def set_cors_headers
    response.headers['Access-Control-Expose-Headers'] = 'Authorization'
  end


  # # Custom action to fetch a user's posts
  # def posts
  #   @user = User.find(params[:id])
  #   @posts = @user.posts # Assuming you have a posts association on your User model
  #   render json: @posts # You can customize this response as needed
  # end
end
