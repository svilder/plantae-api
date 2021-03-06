Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :plants, only: [ :index ], via: :options
    end
  end

  root to: 'pages#home'
end
