Rails.application.routes.draw do
  resources :notices, only: %i[index show create]
  resources :categories, only: %i[index show create]

  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', registration: 'signup' },
             controllers: { sessions: 'sessions', registrations: 'registrations' }
end
