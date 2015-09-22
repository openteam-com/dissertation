Rails.application.routes.draw do
  devise_for :users

  get 'job_status', :as => 'job_status', :to => "job_status#status"

  resources :software_products do
    patch 'upload_csv'
    delete 'destroy_research_items'
    resources :replication_models, :except => [:index, :show]
    resources :research_items, :only => :index
    resources :groupings, :except => [:index, :show] do
      resources :grouping_parameters, :only => [:edit, :update, :destroy]
    end
  end

  root :to => "welcome#index"
end
