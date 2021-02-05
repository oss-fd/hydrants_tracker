Rails.application.routes.draw do

  namespace :api do
    resource :everything, only: %i(show), controller: "everything"
    resources :hydrant_checks, only: %i(create)
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  root to: "landing#show"
end
