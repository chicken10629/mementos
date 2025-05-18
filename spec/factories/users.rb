#FactoryBotを使用したuserの定義 emailやpasswordは自動生成してくれる
#これを基にuserデータを生成するらしい。
FactoryBot.define do
  factory :user do
    name{"スタミナ五郎"}
    introduction{"こんにちわ"}
    is_public{"true"}

    after(:build) do |user|
      user.porfile_image.attach(
        io: File.open(rails.root.join('spec/fixtures/files/アイコン.jpg')),
        filename: 'アイコン.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end