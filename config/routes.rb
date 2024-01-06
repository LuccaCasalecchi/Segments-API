Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users do
    member do
      post 'tags/:tag_id', to: 'user_tags#assign', as: :assign_tag
      delete 'tags/:tag_id', to: 'user_tags#remove', as: :remove_tag
      get 'tags', to: 'user_tags#index'
    end
  end

  resources :tags
  resources :segments
end
