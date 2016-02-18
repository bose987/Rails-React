Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', controllers: {sessions: "manage_sessions"}, at: 'auth'

	get 'check_authorization' => 'users#members_only'
	get 'my_profile' => 'users#my_profile'

	match '*all', to: 'application#preflight', via: [:options]

 
 	namespace :rule do
 		resources :objects

 		get '/objects/:id/attributes', to: 'objects#attributes'
 	end

 	get 	'/expenses',			to: 'expenses#index'
 	post	'/expense',				to: 'expenses#create'
 	get		'/expense/all',			to: 'expenses#view_expenses'
 	get		'/expense/user',		to: 'expenses#view_user_expenses'
 	
 	get 	'/rules', 			to: 'rules#index'
 	get 	'/rules/info', 		to: 'rules#info'

 	post 	'/rule/new', 		to: 'rule#create'
 	get 	'/rule/:id', 		to: 'rule#show'
 	delete 	'/rule/:id', 		to: 'rule#delete'
 	put 	'/rule/:id', 		to: 'rule#edit'

 	get	 '/notifications',				to: 'notifications#index'
 	post '/notification/approve/:id',	to: 'notifications#approve_expense'
 	post '/notification/reject/:id',	to: 'notifications#reject_approval'
end
