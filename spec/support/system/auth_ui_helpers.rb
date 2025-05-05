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

  def login_ui(user)
    visit root_path
    open_navbar_if_collapsed
    visit login_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
  end

  def logout_ui(user)
    open_navbar_if_collapsed
    click_link "ログアウト"
  end