Zigzag::Application.routes.draw do

  resources :home,      :only => [:index, :show]
  resources :reference, :only => [:index, :show]

  root :to => "home#index"

  ## Login and Logout
  match '/login'  =>  'sessions#new'
  match '/logout' =>  'sessions#destroy'

  ## Routes for Items and their types
  resources :items
  match '/items/:id/:type' => 'items#show'

  resources :books,  :controller  => "items", :type => "Book"
  match '/books/:id#:anchor'  => 'items#show'

  resources :chapters,  :controller => "items", :type => "Chapter"
  match '/chapters/:id#:anchor' => 'items#show'

  resources :journals, :controller => "items", :type => "Journal"
  match '/journals/:id#:anchor' => 'items#show'

  resources :articles, :controller => "items", :type => "Article"
  match '/articles/:id#:anchor' => 'items#show'

  ## Routes for Lists
  resources :lists

  ## Routes for Marks
  resources :marks, :only => [:create, :edit]

  resources :quotes,  :controller => "marks", :type => "Quote"
  resources :comment, :controller => "marks", :type => "Comment"
  resources :divider, :controller => "marks", :type => "Divider"

  ## Routes for MarkTerms and MarkTags
  resources :mark_tags,   :only => [:create, :destroy]
  resources :mark_terms,  :only => [:create, :destroy]

  ## Routes for other main resources
  resources :authors
  resources :sessions,    :only => [:create, :destroy]
  resources :users,       :only => [:create, :new, :show]

  ## Resources for search
  resources :searches
  match     '/search'             => 'searches#create'

  resources :search_tags,   :only => [:create, :destroy]
  resources :search_terms,  :only => [:create, :destroy]

end
