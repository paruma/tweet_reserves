Rails.application.routes.draw do
  root :to => redirect("/posts/index")
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/preview" => "posts#preview"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  get "tags/index" => "tags#index"
  get "tags/new" => "tags#new"
  post "tags/create" => "tags#create"
  get "tags/:id/edit" => "tags#edit"
  post "tags/:id/update" => "tags#update"
  post "tags/:id/destroy" => "tags#destroy"

end
