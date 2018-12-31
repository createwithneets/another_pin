Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#we want to see multiple products
resources :products do
  resources :order_items
end

#we only want a user to see ONE Cart

resource :cart

get "info", to: "pages#info"
#get is just one singular page or URL , whereas resources is shorthand for creating 7 URLs like create
#index, show, update, delete, etc.
root "pages#home"

end
