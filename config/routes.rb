Rails.application.routes.draw do
  # blog
  namespace :blog do
    get "/login", to: "sessions#new", as: :login
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy", as: :logout

    # public-facing posts
    resources :posts, only: [ :index, :show ]

    # admin only posts
    namespace :admin do
      resources :posts
    end
  end


  # static pages
  root "home#index"
  get "/about", to: "aboutme#index"
  get "/projects", to: "projects#index"
  get "/resume", to: "resume#index"
  get "/solarbenefits", to: "solarbenefits#index"

  # tdee calculator
  resource :tdee_calculator, only: [ :new, :create ], path: "/tdee"

  # portcharges calculator
  resource :portcharges, only: [ :new, :create ] # resource singular, because it's only the one calculator, and only new and create RESTful routes are needed
  get "portcharges", to: "portcharges#new"

  # solardcalculator
  resource :solardcalculator, only: [ :new, :create ], controller: "solardcalculator"
  get "solardcalculator", to: "solardcalculator#new"

  # broker toolkit
  resource :brokertoolkit, only: [ :new, :create ], controller: "brokertoolkit"
  get "brokertoolkit", to: "brokertoolkit#new"

  # journal app
  namespace :journal do
    # landing page
    root to: "landing#index"

    # user signup (registration)
    get "signup", to: "registrations#new", as: :signup
    post "signup", to: "registrations#create"

    # login/logout (sessions)
    get "login", to: "sessions#new", as: :login
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy", as: :logout

    # notes (full CRUD)
    resources :notes
    # CRUD stands for the four basic operations you can perform on data: create, read, update and delete)
    # resources :notes automatically creates 7 RESTful routes for notes.

    # REST is an architectural style for designing web apps. The 7 RESTful routes are:
    # GET - /journal/notes | notes#index | List all notes (notes dashboard)
    # GET - /journal/notes/new | notes#new | Show new note form
    # POST - /journal/notes	notes#create | Create a note
    # GET - /journal/notes/:id | notes#show | Show a single note
    # GET - /journal/notes/:id/edit | notes#edit | Edit form for a note
    # PATCH/PUT - /journal/notes/:id | notes#update | Update a note
    # DELETE - /journal/notes/:id | notes#destroy | Delete a note
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
end
