Rails.application.routes.draw do
  devise_for :users, controllers: {           #ルートや使用コントローラーをusersに指定
    registrations: 'public/registrations',    #ユーザー登録
    sessions: 'public/sessions',              #ログイン・ログアウト
    passwords: 'public/passwords'             #パスワードの変更
  }
  #devise_for :usersは使用モデルの指定のほかに、
  #users/コントローラーを指定してしまうため、使用するコントローラーを個別に指定しなければならない
  #usersがない場合は元となるdeviseコントローラーそのものを使用するが、今回はこの状態

  scope module: :public do
    get '' => 'homes#top', as: 'top'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
