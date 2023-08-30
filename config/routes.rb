
Rails.application.routes.draw do
  # Define your other routes here

  # namespace :auth do
  #   mount_devise_token_auth_for 'User', at: 'auth', controllers: {
  #     registrations: 'auth/registrations'
  #   }
  # end

  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'auth/registrations'
      }
  # Define your other routes here

  # Define a custom route to get comments for a specific post using GET
  get '/posts/:post_id/comments', to: 'comments#index', as: :post_comments

  # Define a custom route to create a comment for a specific post using POST
  post '/posts/:post_id/comments', to: 'comments#create', as: :create_post_comment

  # Comments like and dislike routes
  post '/posts/:post_id/comments/:comment_id/like', to: 'comment_likes#like', as: :like_comment
  post '/posts/:post_id/comments/:comment_id/dislike', to: 'comment_likes#dislike', as: :dislike_comment

  # Post like and dislikes
  post '/posts/:post_id/like', to: 'post_likes#like', as: :like_post
  post '/posts/:post_id/dislike', to: 'post_likes#dislike', as: :dislike_post

#route for upddtaing profile
patch '/profile', to: 'profiles#update'


get 'category/:id/posts', to: 'categories#posts'


  resources :posts
end
# 