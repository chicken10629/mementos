require 'rails_helper'

Rspec.describe "Users", type: :system do
  let(:user){ FactoryBot.create{:user, name: "スタミナ五郎", introduction: "こんにちわ", is_public: true}}
  
    before do
      # テストユーザーとしてログイン
      sign_in user
      visit my_page_path
    end

    describe "GET /my_page" do

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

        



    end
end