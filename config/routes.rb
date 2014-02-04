Pbctl::Application.routes.draw do

  get "users/new"
  post "song/togglepause"
  post "song/pause"
  post "song/start"
  post "song/skip"
  post "song/like"
  post "song/dislike"
  post "song/volup"
  post "song/voldown"
  post "song/tired"
  post "song/bookmarksong"
  get  "song/details"
  get  "song/art"
  get  "song/description"

  #get "song" => 'song#index'

  root 'song#index'
  
  resources :song, only: [:index]

  get '/populate' => 'stations#populate'

  post '/populate' => 'stations#fill'

  get '/popfile' => 'stations#popfile'

  post '/popfile' => 'stations#fillfile'

  resources :stations

  post 'stations/:id/play' => 'stations#play', as: :play

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  #match 'stations/:id/play', to: 'stations#index', via: 'get'

  #get '/stations/populate'
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
