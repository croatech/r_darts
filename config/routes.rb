Rails.application.routes.draw do
  resources :games, only: %i[index create show]
end
