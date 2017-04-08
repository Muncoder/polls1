Rails.application.routes.draw do
  
	root "pages#home"

	resources :polls do
		resources :questions
		resources :replies, only: [ :new, :create ]
	end

end