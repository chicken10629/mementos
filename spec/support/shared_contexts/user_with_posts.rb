# user.rbやposts.rbを元にデータを生成
# こちらはletなどで定義
let(:user){ create(:user, name: "スタミナ五郎", introduction: "お肉大好き", profile_image: File.new("#{Rails.root}/spec/fixtures/sample-user1.jpg"))}
let!(:post1){ create(:post, title: "10kgダンベル", body: "筋トレのお供", image: File.new("#{Rails.root}/spec/fixtures/アイコン.jpg"))}
let!(:post2){ create(:post, title: "プロテインシェイカー", body: "愛用のボトル", image: File.new("#{Rails.root}/spec/fixtures/no_image.jpg"))}