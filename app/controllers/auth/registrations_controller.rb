
  
# class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController


#   # Override the DeviseTokenAuth create method to set the first user as admin
#   def create
#     super do |user|
#       if User.count == 1
#         user.update(role: 'admin')
#       end

#       def create_profile(user)
#         Profile.transaction do
#           profile = Profile.create(
#             user: user,
#             first_name: user.name,
#             bio: 'Default bio'
#           )
      
#           if profile.valid?
#             Rails.logger.info("Profile created successfully: #{profile.inspect}")
#           else
#             Rails.logger.error("Error creating profile: #{profile.errors.full_messages}")
#             raise ActiveRecord::Rollback
#           end
#         end
#       end


#     end
#   end


#    # Override the render_create_success method to include the user's profile
#    def render_create_success
#     render json: { user: @resource, profile: @resource.profile }
#   end
 
#    # Override the DeviseTokenAuth sign_up_params method to include additional params
#    def sign_up_params
#     params.require(:user).permit(:name, :email, :password, :password_confirmation)
#   end

# end
class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  # Override the DeviseTokenAuth create method to set the first user as admin
  def create
    super do |user|
      if User.count == 1
        user.update(role: 'admin')
      end
      
      create_profile(user) # Call the create_profile method here
    end
  end
  
  def create_profile(user)
    first_name, last_name = user.name.split(' ', 2) # Split the name into two parts
    
    Profile.transaction do
      profile = Profile.create(
        user: user,
        first_name: first_name, # Set first_name from the split name
        last_name: last_name,   # Set last_name from the split name
        bio: 'Default bio',
        nickname: user.nickname,
        image: user.image
      )
  
      if profile.valid?
        Rails.logger.info("Profile created successfully: #{profile.inspect}")
      else
        Rails.logger.error("Error creating profile: #{profile.errors.full_messages}")
        raise ActiveRecord::Rollback
      end
    end
  end
  

  # def create_profile(user)
  #   Profile.transaction do
  #     profile = Profile.create(
  #       user: user,
  #       first_name: user.name,
  #       bio: 'Default bio',
  #       nickname: user.nickname, # Assign the nickname from user registration
  #       image: user.image # Assign the image URL from user registration
  #     )
  
  #     if profile.valid?
  #       Rails.logger.info("Profile created successfully: #{profile.inspect}")
  #     else
  #       Rails.logger.error("Error creating profile: #{profile.errors.full_messages}")
  #       raise ActiveRecord::Rollback
  #     end
  #   end
  # end
  

  # Override the render_create_success method to include the user's profile
  def render_create_success
    render json: { user: @resource, profile: @resource.profile }
  end

  # Override the DeviseTokenAuth sign_up_params method to include additional params
  # def sign_up_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  # end
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :nickname, :image)
  end
  
end
