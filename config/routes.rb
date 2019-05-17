Rails.application.routes.draw do
  root 'api/base#home'

  resources :members
  resources :projects

  resources :organizations do
    resources :members do
      get 'get-from-azure', to: 'members#azure_list', on: :collection
    end

    resources :projects do
      get 'get-from-azure', to: 'projects#azure_list', on: :collection
    end
  end
end
