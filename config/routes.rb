Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/addbook', to: 'add_book_view#addbook'
  post '/addbook' => 'add_book_view#create'
  get '/remove/:title'=> 'remove#remove'
  post '/remove_books/:title' => 'remove#remove_book'
  get '/edit/:title' => 'edit#editbook'
  post '/edit/:title' => 'edit#edit'
  get '/read/:title' => 'read#read'
end
