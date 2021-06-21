Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'

  get '/requests', to: 'requests#requests'
  post '/requests', to: 'requests#create'
  post '/requests/:id', to: 'requests#update'

  get '/requests/:id/orders', to: 'orders#orders'
  post '/requests/:id/orders', to: 'orders#create'
  post '/orders/:id', to: 'orders#update'

  get '/tables', to: 'tables#get'
end
