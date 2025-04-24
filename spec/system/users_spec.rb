require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) {create(:user)}
  let(:other_user){create(:user)}

  describe 'ユーザーCRUD関連' do
    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        describe 'フォーム'
    end
    describe 'ログイン後' do
    end
  end
end