Rails.application.routes.draw do
  get '/loans/issue' => 'loans#create'
  get '/loans/deposit' => 'loans#show'
  get '/loans/deposit/:loan_id' => 'loans#update'

  get '/borrowers/new' => 'borrowers#create'

  get '/search' => 'search#index'
  get '/search/fetch' => 'search#show'

  get '/fines/update/:secret_token' => 'fines#update'

  root 'home#index'
  get 'about', to: 'home#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
