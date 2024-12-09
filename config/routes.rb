Rails.application.routes.draw do
  devise_for :users, controllers: {           #ルートや使用コントローラーをusersに指定
    registrations: 'public/registrations',    #ユーザー登録
    sessions: 'public/sessions',              #ログイン・ログアウト
    passwords: 'public/passwords'             #パスワードの変更
  }
  #devise_for :usersは標準のdeviseコントローラーを指定してしまうため、
  #カスタマイズしている場合は使用するコントローラーを個別に指定しなければならない

  scope module: :public do
    get '' => 'homes#top', as: 'top'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
