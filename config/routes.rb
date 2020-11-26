Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :v1, defaults: { format: :json } do

    resources :structures

    resources :organizations

    resources :users, only: [:create, :show]  do
       collection do
         get  'unconfirmed_users'
         post 'confirm_token'
         post 'login'
         post 'forgot_password'
         post 'reset_password'
       end
     end

   end

end
