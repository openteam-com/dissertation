Rails.application.routes.draw do
  devise_for :users

  get 'job_status', :as => 'job_status', :to => "job_status#status"

  resources :software_products do
    resources :replication_models, :except => [:index, :show]
    resources :research_items, :only => :index

    resources :groupings, :except => [:index, :show] do
      resources :grouping_parameters, :only => [:edit, :update, :destroy]
      resources :alternatives, :only => [:index, :edit, :update]
      resources :parameter_weights, :only => [:show, :edit, :update]

      resources :segments, :only => [:index, :edit, :update] do
        get 'rebuild_segments', :on => :collection
      end
    end

    patch 'upload_csv'
    delete 'destroy_research_items'
  end

  root :to => "welcome#index"
end
