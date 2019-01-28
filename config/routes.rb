Rails.application.routes.draw do
  get 'remote/index'
  get 'remote/test'
  post 'remote/serviceConnect'
  post 'remote/serviceDisconnect'
  post 'remote/getDeviceInfo'
  post 'remote/sendPushNotification'
  root  'remote#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
