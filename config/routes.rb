OmniauthDeviseTestApp::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root "static_pages#home"

  match '/signup1',  to: 'users#new_type1', via: 'get'
  match '/signup2',  to: 'users#new_type2', via: 'get'
  match '/create_from_twitter', to: 'user_type1s#create_from_twitter', via: 'get'
  match '/create_from_facebook', to: 'user_type1s#create_from_facebook', via: 'get'
  
  get '/home', to: 'protected_static_pages#home', as:'user_home'
  get '/create_type1', to: 'thing1s#new', as: 'thing1_create'
  get '/create_type2', to: 'thing2s#new', as: 'thing2_create'
  get '/create_type3', to: 'thing3s#new', as: 'thing3_create'

  get '/destroy_thing', to: 'user_type1s#destroy_thing', as: 'thing_destroy'

  resources :users, :user_type1s, :user_type2s, :thing1s, :thing2s, :thing3s


end
