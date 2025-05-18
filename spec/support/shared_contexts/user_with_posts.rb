# user.rbやposts.rbを元にデータを生成
# こちらはletなどで定義
RSpec.shared_context 'user_and_posts' do
  let(:user){ create(:user, name: "スタミナ五郎", introduction: "お肉大好き", profile_image: File.new("#{Rails.root}/spec/fixtures/files/sample-user1.jpg"))}
  let!(:post1){ create(:post, title: "10kgダンベル", body: "筋トレのお供", image: File.new("#{Rails.root}/spec/fixtures/files/icon.jpg"))}
  let!(:post2){ create(:post, title: "プロテインシェイカー", body: "愛用のボトル", image: File.new("#{Rails.root}/spec/fixtures/files/no_image.jpg"))}
end