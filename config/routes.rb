Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "static#dashboard"
  resources :expenses
  get '/users/:user_id/split_expenses', to: 'split_expenses#index', as: :users_expenses
  get 'people/:id', to: 'static#person'
end
