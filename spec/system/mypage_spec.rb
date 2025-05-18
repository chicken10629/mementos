require 'rails_helper'
#今回はブラウザを開いてリンククリックやフォーム入力等、ユーザー操作をするのでsystem
#typeに指定するのはディレクトリの名前
#個人サイトレベルの規模なため、結合テスト(system)のみでよさそう
#Rspecはtypeを見てからRailsやgemの対応するモジュールを読み込むため、type次第で使えないヘルパーもある
#例：type: :controllerではdeviseのsign_inが使えるが、type: :systemでは無理
Rspec.describe "マイページ（current_user専用）のテスト", type: :system do
  include Warden::Test::Helpers
  
  #Wardenはdeviseと一緒に入っている。systemテストでログインするときに必要


  #beforeはテスト前に必ず実行される。let!と似ているが、こちらは変数として利用可能
    before do
      # テストユーザーとしてログイン
      # visitはcapybaraのヘルパー
      login_via_ui(user)
      visit my_page_path
    end

    after do
      # logoutは(user)不要
      logout_via_ui
    end

    describe "マイページにアクセス" do
      # it毎に別のブラウザセッション扱いになるらしい。そのためセッションはitの外に書いても引き継がれない
      # 各テストケース(it)中か、beforeブロックで毎回ログインする必要がある
      it "正常にマイページが表示される" do
        # ログイン済み状態でマイページにアクセス
        expect(page).to have_content("スタミナ五郎")
        expect(page).to have_content("こんにちわ")
      end

      it "プロフィール編集リンクが表示・リンク先に遷移できる" do
        click_link "プロフィールを編集する"
        #click_linkの後に画面遷移しているため、current_pathが編集画面であるか確認する
        expect(current_path).to eq(edit_post_path(user.id))
      end

      it "いいね一覧リンクが表示・リンク先に遷移できる" do
        click_link "いいね一覧を表示"
        expect.(current_path).to eq(my_favorites_path)
      end

      it "フォロー一覧リンクが表示・リンク先に遷移できる" do
        click_link "フォローユーザー一覧を表示"
        expect.(current_path).to eq(user_followings_path(user.id))
      end

      describe "公開・非公開設定について"
        it "公開状態の時、非公開設定に切り替えられる" do
          expect(page).to have_content("公開")
          click_link "非公開にする"
          
          #データの更新があったため、変数.reloadで再度データを取得する
          user.reload
          expect(user.is_public).to be_falsey

          expect(page).to have_content("非公開")
          expect(page).to have_link("公開にする")
        end

      describe "投稿一覧の表示" do
        it "投稿画像、タイトル、エピソードが表示される" do
          expect(page).to have_selector('img[src$='アイコン.jpg']')
          expect(page).to have_selector('img[src$='no_image.jpg']')

          expect(page).to have_content('10kgダンベル')
          expect(page).to have_content('プロテインシェイカー')

          expect(page).to have_content('筋トレのお供')
          expect(page).to have_content('愛用のボトル')
        end
        it "タイトル1をクリックして投稿詳細にアクセスできる" do
          click_link "10kgダンベル"
          expect(current_path).to eq(post_path(post1.id))
        end
        it "タイトル2をクリックして投稿詳細にアクセスできる" do
          click_link "プロテインシェイカー"
          expect(current_path).to eq(post_path(post2.id))
        end
      end
    end
end