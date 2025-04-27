require 'rails_helper'
#今回はブラウザを開いてリンククリックやフォーム入力等、ユーザー操作をするのでsystem
#個人サイトレベルの規模なため、結合テストのみでよさそう
#Rspecはtypeを見てからRailsやgemの対応するモジュールを読み込むため、type次第で使えないヘルパーもある
#例：type: :controllerではdeviseのsign_inが使えるが、type: :systemでは無理
Rspec.describe "マイページ（current_user専用）のテスト", type: :system do
  include Warden::Test::Helpers
  
  #Wardenはdeviseと一緒に入っている。systemテストでログインするときに必要

  #インスタンス変数みたいなヘルパーメソッドの定義。
  #テスト内でuserという名前を使ったときにのみ、FactoryBot.create以降を実行
  #letは呼び出されるまで評価されない変数定義。つまりuserを呼ぶまでは何も起こらない。
  let(:user){ FactoryBot.create{:user, name: "スタミナ五郎", introduction: "こんにちわ", is_public: true}}
  let!(:post){ FactoryBot.create{:post, user: user, title: "ハーモニカ", body: "小３の頃から愛用している相棒です。", }}
  #beforeはテスト前に必ず実行される。let!と似ているが、こちらは変数として利用可能
    before do
      # テストユーザーとしてログイン
      #visitはcapybaraのヘルパー
      login_as(user)
      visit my_page_path
    end

    describe "マイページにアクセス" do

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

      it "" do
      end
    end
end