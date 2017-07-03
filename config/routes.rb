Rails.application.routes.draw do
  get 'recipes/index'

  root 'pages#home'
  get 'pages/home', to: 'pages#home'

  get '/recipes', to: 'recipes#index'
end
