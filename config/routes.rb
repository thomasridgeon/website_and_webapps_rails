Rails.application.routes.draw do
  # static pages
  root "home#index"
  get "/about", to: "aboutme#index"
  get "/projects", to: "projects#index"
  get "/resume", to: "resume#index"
  get "/sunbenefits", to: "sunbenefits#index"

  # portcharges calculator
  resource :portcharges, only: [ :new, :create ]
  get "portcharges/new"
  get "portcharges/create"

  # solardcalculator
  resource :solardcalculator, only: [ :new, :create ]
  get "solardcalculator/new"
  get "solardcalculator/create"

  # journal app
  namespace :journal do
    resources :notes
    get "landing/index"
    get "/signup", to: "registrations#new"
    post "/signup", to: "registrations#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
  end
end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

# Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
# get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
# get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

# Defines the root path route ("/")
# root "posts#index"
