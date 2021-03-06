Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tasks
      resources :posts
      resources :tags, except: %i[show destroy]
    end
  end
end
