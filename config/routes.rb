Rails.application.routes.draw do
  root 'home#index'
  post '/generate_json', to: 'home#generate_json'
end
