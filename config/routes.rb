Rails.application.routes.draw do
  devise_for :users

  resources :software_products do
    resources :replication_models, :except => [:index, :show]
  end

  root :to => "welcome#index"
end
