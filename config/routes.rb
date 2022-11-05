Rails.application.routes.draw do
  resources :dog_houses, only: [:show] do
    # nested resource for reviews
    # Hmmmm... does this mean for each of the above routes, which would would only be show, we are stacking onto that route, the reviews associated with that dog house, and an individual review of that dog house. 
    # This would be in contrast to: 
    # get '/dog_houses/:dog_house_id/reviews'
    # get '/dog_houses/:dog_house_id/reviews/:review_id'
    resources :reviews, only: [:show, :index]
  end
  resources :reviews, only: [:show, :index, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
