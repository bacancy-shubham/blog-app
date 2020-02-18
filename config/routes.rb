Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'users/registrations', sessions: 'users/sessions', passwords: 'users/passwords', confirmations: 'users/confirmations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   resources :articles do
    get 'home', on: :collection, action: :home
   end 
   root to: "articles#home"
end
