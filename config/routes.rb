Rails.application.routes.draw do

  #user用のログイン回りのコントローラー
  devise_for :users, controllers: {           #ルートや使用コントローラーをusersに指定
    registrations: 'public/registrations',    #ユーザー登録
    sessions: 'public/sessions',              #ログイン・ログアウト
    passwords: 'public/passwords'             #パスワードの変更
  }
  #devise_for :usersは標準のdeviseコントローラーを指定してしまうため、
  #カスタマイズしている場合は使用するコントローラーを個別に指定しなければならない

  #admin用。ログインのコントローラーのみ使用
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards/index' => 'dashboards#index', as: 'top'
    resources :posts, only: [:index, :show, :edit, :destroy, :update]
    resources :users, only: [:index, :show, :edit, :destroy, :update]
  end

  scope module: :public do #namespaceの指定をコントローラーのみにする。URLに含めない。
    #ファイル名とアクション名は一致させる必要アリ。アクション名を#mypageにしたらエラーがでてしまった。
    get '' => 'homes#top', as: 'top'
    get 'users/my_page' => 'users#my_page', as: 'my_page'#URL、コントローラー#アクション名、パス名
    get 'users/my_page/edit/:id' => 'users#my_page_edit', as: 'my_page_edit'
    patch 'users/my_page/edit/:id' => 'users#my_page_update', as: 'my_page_update'
    put 'users/my_page' => 'users#withdraw', as: 'withdraw'
    patch 'users/my_page/public_status' => 'users#public_status', as: 'my_page_public_status'
    resources :users, only: [:index, :show] do
      resources :follows, only: [:index, :create, :destroy] #usersにネスト
      resources :favorites, only: [:index]
    end

    resources :posts do
      resources :post_comments, only: [:create] do
        patch 'delete', on: :member #on: :memberはカスタムアクション名を定義する際、idが必要なルートを定義するときに使用。indexはon: :collection
      end
      resources :favorites, only: [:index, :create, :destroy]
    end

    get 'search/index' => 'searches#index', as: 'search_index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
  
  #パス名を分けておかないとpublicコントローラーを使いだしてしまったので変更。

end
