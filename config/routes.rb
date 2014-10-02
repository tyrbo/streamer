Rails.application.routes.draw do
  root 'assets#index'

  get '/auth/:provider/callback', to: 'sessions#create'
end
