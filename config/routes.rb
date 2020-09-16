Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      root to: 'plants#index', via: :options
    end
  end
end
