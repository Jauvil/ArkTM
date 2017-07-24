Rails.application.routes.draw do
  devise_for :users
  resources :users, :only => [:show]
  resources :tribes
  resources :job_templates
  resources :dinos

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tribes#index"
  get '/tribes/:id/tribe_request', to: 'tribes#tribe_request', as: 'tribe_request'
  get 'tribes/:id/tribe_request_accept', to: 'tribes#tribe_request_accept', as: 'tribe_request_accept'
  get 'tribes/:id/tribe_request_decline', to: 'tribes#tribe_request_decline', as: 'tribe_request_decline'
end
