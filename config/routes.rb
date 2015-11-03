Rails.application.routes.draw do
  root "admin/accounts#index"
  namespace :admin do
    resources :accounts do
      resources :transactions
    end
    resources :transactions
  end
end
