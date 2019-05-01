Rails.application.routes.draw do
  devise_for :users
  get "top/show"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :login, only: [:create], controller: :session
      resource :users, only: [:create, :update] do
        collection do
          post :upload_icon
        end
      end
      resources :rooms, only: [:index, :create, :show] do
        collection do
          get :popular
          get :recommend
        end
      end
      get "joined_rooms", to: "users#joined_rooms"
      get "youtube/search", to: "youtube#search"
      get "youtube/video", to: "youtube#video"
      post "user_report", to: "user_report#create"
    end
  end

  root to: "top#show"
  mount ActionCable.server => "/cable"
end
