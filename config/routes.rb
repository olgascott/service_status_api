Rails.application.routes.draw do
  root to: 'home#index'

  scope '/api/1', constraints: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resource :signup, only: [:create], controller: :users

    resources :reports, only: [:create]
  end
end
