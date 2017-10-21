Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/sessions/new' => 'sessions#new', as: :new_session
  post '/sessions' => 'sessions#create', as: :sign_in
  delete '/sessions' => 'sessions#destroy', as: :logout

  resources :tickets

  post "tikets/:id/payment" => 'tickets#payment', as: :payment
  get "tikets/:id/bill" => 'tickets#bill', as: :bill

  root to: 'tickets#index'
end
