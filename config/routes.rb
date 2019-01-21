Rails.application.routes.draw do
  root 'rooms#show'
  resources :scrapes, only: [:index, :new]
end
