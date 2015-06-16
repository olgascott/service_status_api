Rails.application.routes.draw do
  root to: 'home#index'

  scope '/api/1', constraints: { format: :json } do
    resources :reports, only: [:create]
  end
end
