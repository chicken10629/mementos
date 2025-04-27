#systemテスト時、beforeでログインする場合はログアウトしなおす
#itが終わった直後に毎回実行する
Rspec.configure do |config|
  config.include Warden::Test::Helpers
  config.after(type: :system) do
    Warden.test_reset!
  end
end