Rails.application.routes.draw do
  devise_for :users
  
  #ホーム画面ルーティング
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  
  #userルーティング
  resources :users, only:[:show, :edit, :update, :destroy] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end
  get 'customers/leave' => 'customers#leave'
  
  #itemルーティング
  resources :items do
    resource :item_comments, only:[:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  
  #genreルーティング
  resources :genre, only:[:index, :edit, :create, :update, :destroy]
  
end
