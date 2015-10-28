Rails.application.routes.draw do
  devise_for :users

  get 'job_status', :as => 'job_status', :to => "job_status#status"

  resources :software_products do
    resources :replication_models, :except => [:index, :show]
    resources :research_items, :only => :index

    resources :groupings, :except => [:index, :show] do
      resources :grouping_parameters, :only => [:edit, :update, :destroy]
      resources :parameter_weights, :only => [:show, :edit, :update]
      resources :alternatives, :only => [:index, :edit, :update, :show] do
        resources :accomodation_waves, :except => [:index]
        patch 'upload_csv', :on => :member
        delete 'destroy_advertising_tools', :on => :member
      end

      resources :segments do
        get 'rebuild_segments', :on => :collection
      end

     get 'selected_alternatives', :on => :member
     get 'alternatives_selection', :on => :member
    end

    patch 'upload_csv', :on => :member
    delete 'destroy_research_items', :on => :member
  end

  root :to => "welcome#index"
end
