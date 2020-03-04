Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'users/registrations', sessions: 'users/sessions', passwords: 'users/passwords', confirmations: 'users/confirmations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   resources :articles do
       get 'request', on: :collection, action: :article_request
       get 'accept_request' , to: 'articles#article_accept_request'
       get 'reject_request' , to: 'articles#article_reject_request'
      # get 'article_reject_request', on: :collection, action: :article_request_reject 
      resources :comments
      get 'home', on: :collection, action: :home
   end 
   resources :likes, only: [:create, :destroy]
   get 'notification' , to: 'articles#notification'
   root to: "articles#home"
end
