Rails.application.routes.draw do
  get '/loans/issue' => 'loans#create'
  get '/loans/deposit' => 'loans#show'
  get '/loans/deposit/:loan_id' => 'loans#update'

  get '/search' => 'search#show'

  root 'home#index'
  get 'about', to: 'home#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
