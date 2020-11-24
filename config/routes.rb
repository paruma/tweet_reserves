Rails.application.routes.draw do
  root :to => redirect("/posts/index")
  get "posts/index" => "posts/index"
  get "posts/new" => "posts/new"
  post "posts/create" => "posts/create"
  get "posts/preview" => "posts/preview"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
