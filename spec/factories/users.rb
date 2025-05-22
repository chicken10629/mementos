#FactoryBotを使用したuserの定義 emailやpasswordは自動生成してくれるハズだが、ログインできなかったので設定。
#これを基にuserデータを生成するらしい。
FactoryBot.define do
  factory :user do
    name { Facker::Name.name(number: 10) }
    introduction {Facker::Lolem.characters(number: 50 )}
    is_public{"true"}
    email{Facker::Internet.free_email}
    password{Facker::Internet.password(min_length: 8)}

    after(:build) do |user|
      user.profile_image.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/icon.jpg')),
        filename: 'icon.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end