Rails.application.routes.draw do
  root 'assets#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :games, only: [:index, :show]
    end
  end
end
