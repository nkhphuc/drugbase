Rails.application.routes.draw do
  resources :posts do
    patch :change_status, on: :member
  end
  resources :drugs do
    resources :products, only: [:create, :destroy]
  end
  resources :workplaces
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  as :user do
    get "signin" => "devise/sessions#new"
    post "signin" => "devise/sessions#create"
    delete "signout" => "devise/sessions#destroy"
    get "signup" => "devise/registrations#new"
  end

  root "pages#home"
  get "about" => "pages#about", as: "about"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
