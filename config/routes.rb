Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
   
  }
  get'albums/draft'

  resources :albums do
   member do
   delete :purge_cover_photo , :delete_image_attachment
 
   end
  end

 root'albums#index'
 get "/users", to: "albums#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
