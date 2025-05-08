# user.rbやposts.rbを元にデータを生成
# こちらはletなどで定義
let(:user){ create(:user, name: "スタミナ五郎", introduction: "お肉大好き")}
let!(:post1){ create(:post, title: "10kgダンベル", body: "筋トレのお供")}