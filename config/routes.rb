Rails.application.routes.draw do
    
  unauthenticated do
    root 'home#index'
  end
  authenticated :user do
    root 'users#index', as: 'authenticated_user_root'
  end

  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords', omniauth_callbacks: 'users/omniauth_callbacks' }, skip: :registrations
  devise_scope :user do
    get 'users/sign_up' => 'users/registrations#new', as: 'new_user_registration'
    post 'users' => 'users/registrations#create', as: 'user_registration'
  end

  resources :users, except: [:new, :create] do
    member do
      get 'add_password'
      patch 'create_password'
    end
  end

  resources :city_state, only: [] do
    collection do
      post 'state'
      post 'city'
    end
  end
      
  resources :activities, only: [:index, :show] do
    member do
      post 'add_to_interests'
    end
  end

  resources :schedules, except: [:edit, :update]

  resources :schedule_responses, only: [] do
    member do
      post 'accept'
      post 'decline'
    end
  end

end
