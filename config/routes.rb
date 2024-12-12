Rails.application.routes.draw do
  devise_for :users, controllers: {           #ルートや使用コントローラーをusersに指定
    registrations: 'public/registrations',    #ユーザー登録
    sessions: 'public/sessions',              #ログイン・ログアウト
    passwords: 'public/passwords'             #パスワードの変更
  }
  #devise_for :usersは標準のdeviseコントローラーを指定してしまうため、
  #カスタマイズしている場合は使用するコントローラーを個別に指定しなければならない

  scope module: :public do #namespaceの指定をコントローラーのみにする。URLに含めない。
    get '' => 'homes#top', as: 'top'
    get 'users/my_page' => 'users#mypage', as: 'my_page'#URL、コントローラー#アクション名、パス名
    get 'users/my_page/edit' => 'users#edit', as: 'my_page_edit'
    patch 'users/my_page' => 'users#update', as: 'my_page_update'
    patch 'users/my_page/public_status' => 'users#public_status', as: 'my_page_public_status'
    resources :users, only: [:index, :show] do
      resources :follows, only: [:index, :create, :destroy] #usersにネスト
    end

    resources :posts do
      resources :post_comments, only: [:create] do
        patch 'delete', on: :member #on: :memberはカスタムアクション名を定義する際、idが必要なルートを定義するときに使用。indexはon: :collection
      end
      resources :favorites, only: [:index, :create, :destroy]
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
