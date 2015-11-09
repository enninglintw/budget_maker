Rails.application.routes.draw do
  root "admin/accounts#index"
  namespace :admin do
    resources :accounts
  end
end
