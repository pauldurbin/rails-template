Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login', sign_out: 'logout'
  }

  namespace :admin do
    root to: "dashboards#show"

    concern :select_or_create do
      collection do
        get :select_or_create
      end
      member do
        post :clone
      end
    end

    resource :dashboards, only: :show, path: 'dashboard'
    resources :site_selections, path: 'site-selection', only: [:new, :create]

    resources :sites
    resources :templates
    resources :users
    resources :resources

    resources :pages do
      collection do
        post :sort
      end
      resources :shelves, concerns: :select_or_create do
        resources :content_items, concerns: :select_or_create
      end
    end

    resources :sortable, only: :index do
      collection do
        post :sort
      end
    end
  end

  resources :contacts, path: 'contact-us', slug: 'contact-us', only: [:index, :new, :create] do
    collection do
      get :thankyou
    end
  end

  get '/:slug' => 'pages#show', as: :page
  root to: 'pages#show', slug: 'home'
end
