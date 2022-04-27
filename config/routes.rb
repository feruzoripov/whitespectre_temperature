Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  match 'offset', to: 'temperatures#set_offset', via: [:get, :post]
  match 'temperature', to: 'temperatures#create_temperature', via: [:get, :post]
  match 'list', to: 'temperatures#list_temps', via: [:get]
end
