Rails.application.routes.draw do
  resources :likes
  resources :comments
  resources :friendships
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'}


  resources :users, only: [:show, :edit, :update] do
    resources :posts do
      resources :comments
    end
  end





  root to: "home#index"
end
