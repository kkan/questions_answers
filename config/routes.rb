Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers, only: [:create, :destroy]
    get :answers, to: 'questions#show', on: :member
  end

  root 'questions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
