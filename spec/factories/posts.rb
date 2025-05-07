#factorybotを使ったデフォルトのダミーデータ。使うファイル側で中身をセットし直す。
#これを基にpostデータを作るらしい。
FactoryBot.define do
  Factory :post do
    title {"初期データ"}
    body {"何か入力してください"}
    association :user #ユーザーとの関連

    after(:build) do |post|
      post.image.attach(
        io: File.open(rails.root.join('spec/fixtures/files/sample-user1.jpg')),
        filename: 'sample-user1.jpg',
        content_type: 'image/jpeg'
      )
  end
end
