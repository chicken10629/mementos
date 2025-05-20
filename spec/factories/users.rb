#FactoryBotを使用したuserの定義 emailやpasswordは自動生成してくれる
#これを基にuserデータを生成するらしい。
FactoryBot.define do
  factory :user do
    name{"スタミナ五郎"}
    introduction{"こんにちわ"}
    is_public{"true"}

    after(:build) do |user|
      user.profile_image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/icon.jpg')),
        filename: 'icon.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end