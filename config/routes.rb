Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'users#index'
  get '/employers', to: 'employers#index'
  get '/employees', to: 'employees#index'
  get '/budgets', to: 'budgets#index'
  get '/timesheets', to: 'timesheets#index'
end
