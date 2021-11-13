Rails.application.routes.draw do
  root to: 'home#index'
  resources :articles do
    resources :comments
  end
  devise_for :users

  get "myarticles", to: "articles#user_articles"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
