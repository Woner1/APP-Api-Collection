Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      resources :users
      #register login
      post 'access_tokens',to: 'access_tokens#create'

      #verification code
      post 'phone_verifications',to: "phone_verifications#create"
    end
  end
end
