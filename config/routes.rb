Rails.application.routes.draw do
  get 'welcome/index' => 'welcome#index'
  get 'welcome/about' => 'welcome#about'
  root 'welcome#index'
end
