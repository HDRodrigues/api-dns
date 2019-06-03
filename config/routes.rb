Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'dns', to: 'domain_name_systems#index'
    end
  end
end
