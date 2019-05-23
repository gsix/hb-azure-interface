Rails.application.routes.draw do
  devise_for :users
  root 'application#home'

  resources :members
  resources :projects do
    get 'create-in-hb', action: 'create_in_hb', on: :member
    get 'azure-hooks-create', action: 'azure_hooks_create', on: :member
  end
  resources :tasks

  resources :organizations do
    get 'edit_hubstaff_access', to: 'organizations#edit_hubstaff_access', on: :member
    get '/hubstaff_start_auth_code_callback', to: 'organizations#hubstaff_start_auth_code', on: :collection
    post 'update_hubstaff_start_auth_code', to: 'organizations#update_hubstaff_start_auth_code', on: :member

    resources :members do
      get 'get-from-azure', to: 'members#azure_list', on: :collection
    end

    resources :projects do
      get 'get-from-azure', to: 'projects#azure_list', on: :collection
    end
  end

  scope :api do
    root to: 'api/base#home'

    scope :tasks do
      post 'azure_hook_create', to: 'api/tasks#azure_hook_create', as: :azure_hook_task_create
      post 'azure_hook_update', to: 'api/tasks#azure_hook_update', as: :azure_hook_task_update
      post 'azure_hook_destroy', to: 'api/tasks#azure_hook_destroy', as: :azure_hook_task_destroy
    end
  end
end
