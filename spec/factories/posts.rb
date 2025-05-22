#factorybotを使ったデフォルトのダミーデータ。使うファイル側で中身をセットし直す。
#これを基にpostデータを作るらしい。
FactoryBot.define do
  factory :post do
    title {Facker::Lorem.characters(number: 10)}
    body { Facker::Lorem.characters(number: 50)}
    association :user #ユーザーとの関連

    after(:build) do |post|
      post.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/sample-user1.jpg')),
        filename: 'sample-user1.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
