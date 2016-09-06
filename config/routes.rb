Rails.application.routes.draw do
  root 'settings#index'

  get 'settings/' => 'settings#index'
  get 'settings/index'
  get 'settings/type'
  get 'settings/resolution'
  get 'settings/now'
  get 'settings/rainbow'
  get 'settings/worm'

  get 'data_points/' => 'data_points#act'
end
