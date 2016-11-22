#
# resources :posts    <= will automatically generates all the necessary routes
#                        for posts
# If you want to generate only one, you can use
#   resources :posts only: :update
# If you want to generate more than one, you can use
#   resources :posts only: [:edit, :update]
#
Rails.application.routes.draw do
  resources :questions
  resources :posts

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
