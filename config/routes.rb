Chicoplusplus::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, :path => 'account', :controllers => {:registrations => 'registrations'}

  resources :inquiries, :only => [:new, :create]
  resources :topics do
    member do
      match 'vote/:direction' => 'topics#vote', :as => 'vote'
    end
  end

  match 'privacy' => 'home#privacy'
  match 'terms' => 'home#terms'
  match 'about' => 'home#about'

  root :to => 'home#index'
  get "home/index"
end
