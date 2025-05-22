# user.rbやposts.rbを元にデータを生成
# こちらはletなどで定義
RSpec.shared_context 'user_and_posts' do
  let!(:user){ create(:user, name: "スタミナ五郎", introduction: "お肉大好き" )}
  let!(:post1){ create(:post, title: "10kgダンベル", body: "筋トレのお供", user: user)}
  let!(:post2){ create(:post, title: "プロテインシェイカー", body: "愛用のボトル", user: user)}
end