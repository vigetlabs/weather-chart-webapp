Rails.application.routes.draw do
  root 'settings#party'

  get 'party/' => 'settings#party'
  get 'settings/' => 'settings#index'
  get 'settings/index'
  get 'settings/type'
  get 'settings/resolution'
  get 'settings/now'
  get 'settings/rainbow'
  get 'settings/worm'
  patch 'settings/light'
  patch 'settings/zipcode'

  patch '/party', to: "settings#update"

  get 'data_points/' => 'data_points#act'
end
