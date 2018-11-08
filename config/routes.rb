Rails.application.routes.draw do
  devise_for :users,
     path: '',
     path_names: {
       sign_in: 'login',
       sign_out: 'logout',
       registration: 'signup'
     },
     controllers: {
       sessions: 'sessions',
       registrations: 'registrations'
     }

     resources :posts, only: [:create, :show]
     get 'user', to: "users#show"
end
