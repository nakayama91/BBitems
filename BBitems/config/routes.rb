Rails.application.routes.draw do

  # inquiryルーティング
  get 'inquiry/index'   => 'inquiry#index'
  post 'inquiry/confirm' => 'inquiry#confirm'
  post 'inquiry/thanks'  => 'inquiry#thanks'

  # rails_adiminルーティング
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # deviseルーティング
  devise_for :users, controllers: {   registrations: 'users/registrations',
                                      sessions: 'users/sessions' } # コントローラーの編集内容を反映させる

  # ホーム画面ルーティング
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  # userルーティング
  resources :users, only: %i[show index] do
    resource :relationships, only: %i[create destroy]
    get 'followings', on: :member
    get 'followers', on: :member
    resources :likes, only: %i[create destroy]

    collection do
      get 'users/leave' => 'users#leave', as: 'leave'
    end
  end

  # itemルーティング
  resources :items do
    resources :item_comments, only: %i[create destroy]
    resource :likes, only: %i[create destroy]
  end
  get 'genre_index' => 'items#genre_index', as: 'genre_index'

  # genreルーティング
  resources :genres, only: %i[index show edit create update destroy]

  # searchルーティング
  get '/search' => 'searchs#index', as: 'index' # 投稿の検索結果

end
