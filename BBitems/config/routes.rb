Rails.application.routes.draw do
  devise_for :users, controllers: {   registrations: 'users/registrations',
                                      sessions: 'users/sessions' } #コントローラーの編集内容を反映させる

  #ホーム画面ルーティング
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  #userルーティング
  resources :users, only:[:show, :index] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'

    collection do
      get 'users/leave' => 'users#leave', as:"leave"
    end
  end

  #itemルーティング
  resources :items do
    resource :item_comments, only:[:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end

  #genreルーティング
  resources :genres, only:[:index, :edit, :create, :update, :destroy]

end
