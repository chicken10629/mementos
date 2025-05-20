# systemテスト時、beforeでログイン・afterでログアウト
# itが終わった直後に毎回実行する
# 今回はリンクを踏んでログインorログアウトしたいのでUI無視して内部で処理するタイプではない
module AuthUiHelpers
  # visible、つまりbootstrapで作ったハンバーガーボタンが見える場合のみ有効。
  def open_navbar_if_collapsed
    if page.has_selector?('button.navbar-toggler', visible: true)
      find('button.navbar-toggler').click_button
    end
  end

  def login_via_ui(user)
    visit root_path
    open_navbar_if_collapsed
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_link "ログイン"
  end

  def logout_via_ui
    open_navbar_if_collapsed
    click_link "ログアウト"
  end
end

# このモジュールをこのタイプのテストで使えるようにして？と明示する。Rspecではこれを指定しないとテストで読み込んでくれない。
# rails_helperではなく、モジュールを定義したファイルに記述するのが基本らしい。
RSpec.configure do |config|
  config.include AuthUiHelpers, type: :system
end
