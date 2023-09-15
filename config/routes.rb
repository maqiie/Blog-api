
Rails.application.routes.draw do
  # Define your other routes here


  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'auth/registrations'
      }
  # Define your other routes here


  get '/users/:user_id/posts', to: 'posts#user_posts', as: :user_post

# Route to delete a user's post
delete '/users/:user_id/posts/:id', to: 'posts#destroy', as: :delete_user_post
# get 'category/:id/posts', to: 'categories#posts', as: :category_posts
# get '/categories/:id/posts', to: 'categories#posts', as: :category_posts
# get '/posts/category/:name', to: 'categories#posts_by_name', as: :category_posts

# config/routes.rb

get '/categories/:name', to: 'categories#show', as: 'category'



  # Define a custom route to get comments for a specific post using GET
  get '/posts/:post_id/comments', to: 'comments#index', as: :post_comments

  # Define a custom route to create a comment for a specific post using POST
  post '/posts/:post_id/comments', to: 'comments#create', as: :create_post_comment
  # config/routes.rb

# Define a custom route to delete a comment for a specific post using DELETE
delete '/posts/:post_id/comments/:id', to: 'comments#destroy', as: :delete_comment



  # Comments like and dislike routes
  post '/posts/:post_id/comments/:comment_id/like', to: 'comment_likes#like', as: :like_comment
  post '/posts/:post_id/comments/:comment_id/dislike', to: 'comment_likes#dislike', as: :dislike_comment
  
get '/posts/:post_id/comments/:comment_id/likes', to: 'comment_likes#show', as: 'comment_likes'

  # Post like and dislikes
  post '/posts/:post_id/like', to: 'post_likes#like', as: :like_post
  post '/posts/:post_id/dislike', to: 'post_likes#dislike', as: :dislike_post
# config/routes.rb
get '/posts/:post_id/likes', to: 'likes#index', as: :post_likes

#route for upddtaing profile
patch '/profile', to: 'profiles#update'

# config/routes.rb
resources :posts do
  member do
    post 'like', to: 'post_likes#like'
    post 'dislike', to: 'post_likes#dislike'
    get 'likes', to: 'posts#likes' # Route to fetch likes only
    get 'dislikes', to: 'posts#dislikes'
  end
end


get 'category/:id/posts', to: 'categories#posts'

get '/categories', to: 'categories#index'
  resources :posts

  
resources :categories, only: [:index]

end
# 