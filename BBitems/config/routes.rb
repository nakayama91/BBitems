Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {   registrations: 'users/registrations',
                                      sessions: 'users/sessions' } #コントローラーの編集内容を反映させる

  #ホーム画面ルーティング
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  #userルーティング
  resources :users, only:[:show, :index] do
    resource :relationships, only: [:create, :destroy]
    get 'followings', on: :member
  	get 'followers', on: :member
  	resources :likes, only: [:create, :destroy]

    collection do
      get 'users/leave' => 'users#leave', as:"leave"
    end
  end

  #itemルーティング
  resources :items do
    resources :item_comments, only:[:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  get 'sortindex' => 'items#sortindex', as:"sortindex"

  #genreルーティング
  resources :genres, only:[:index, :show, :edit, :create, :update, :destroy]

  #searchルーティング
  get '/search' => 'searchs#index', as:"index" #投稿の検索結果

end
