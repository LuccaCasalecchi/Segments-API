Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users do
    member do
      post 'tags/:tag_id', to: 'user_tags#assign', as: :assign_tag
      delete 'tags/:tag_id', to: 'user_tags#remove', as: :remove_tag
      get 'tags', to: 'user_tags#index'
      get 'tags/:tag_id', to: 'user_tags#show', as: :user_tag
    end

    resources :segments, controller: 'user_segments', only: [:index, :create, :destroy]
  end

  resources :tags

  resources :segments do
    member do
      get 'users', to: 'segments_user#index'
    end
    resources :rules, controller: 'segment_rules'
  end
end
