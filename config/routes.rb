Rails.application.routes.draw do
  resources :users

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  resources :sessions, only: [:new, :create, :destroy]

  post '/login' => 'sessions#create'
  delete '/logout' => "sessions#destroy"

  root 'trips#splash'

  resources :categories

  resources :locations

  resources :expenses, only: [:index]

  resources :trips do
    collection do
      post 'from_expenses'
    end
    resources :expenses, shallow: true
  end

  get "/fetch_expenses" => 'users#from_trip', as: 'fetch_expenses'
  get "/fetch_wishlist_items" => 'users#from_wishlist', as: 'fetch_wishlist_items'

  resources :wishlists

  #resources :wishlist_items

  get "/fetch_new_trip" => 'users#new_trip', as: 'fetch_new_trip'

  post "/add_to_wishlist" => 'expenses#add_to_wishlist', as: 'add_to_wishlist'

  get "/fetch_new_wishlist" => 'users#new_wishlist', as: 'fetch_new_wishlist'

  post '/toggle' => 'users#toggle'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
