class ProfilesController < ApplicationController
    before_action :authenticate_user!
  
    def update
      @profile = current_user.profile
  
      if @profile.update(profile_params)
        render json: { message: 'Profile updated successfully', profile: @profile }
      else
        render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :bio)
    end
  end
  
