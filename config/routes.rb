Rails.application.routes.draw do

  namespace :api do
    resource :everything, only: %i(show), controller: "everything"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  root to: "landing#show"
end
