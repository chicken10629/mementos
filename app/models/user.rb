class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :profile_image #アイコン画像のデータ

  #テーブルの関連付け
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :visits, dependent: :nullify # 消すときに外部キーのuser_idがnullになる。
  
  # フォローした、されたユーザーのデータを取得するメソッド
  # 指定したモデルとの関連付けと外部キーを指定。
  # followersはメソッド名らしいため、自由に名を付けられる。
  # フォロー・フォロー解除のタイミングで使う
  # 命名がややこしすぎるため、次回からpassive/active_relationshipで分かりやすく書く
  has_many :following_users, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy #フォローしている人の取得
  has_many :followers, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy #フォローされた人の取得
  
  #上記メソッドを利用して、フォロー・フォロワー情報を取得。
  # throughはどの中間テーブル（関連）を使用するか？sourceはどのカラムから相手を取得するか？
  # sourceは自分が/をフォローしているユーザーを指定するため、主語がどちらかを意識する。
  #こちらは中間テーブルを介さずユーザーのデータを取ってきてくれる。上の方は中間テーブルのfollowの方だけ。
  has_many :following_list, through: :following_users, source: :followed
  has_many :followers_list, through: :followers, source: :follower
  #following_usersを利用し、following_listとuserモデルを関連付ける。

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: { message: "を入力してください。" }, length: {maximum: 20, message: "は20文字以内で入力してください。"}
  validates :introduction, length: {maximum: 100, message: "は100文字以内で入力してください。"}
  #自分で追加したカラムはバリデーションを設定しないといけないので、nameを追記

  #image拡張子のバリデーション。画像ファイルがある場合に限り作動。
  validate :image_content_type, if: :was_attached?

  #errors.addはバリデーションエラーが起きた時のメッセージ。content_typeはファイルのタイプが何かを示すもの。
  def image_content_type
    extensions = ['image/png', 'image/jpg', 'image/jpeg']
    errors.add(:profile_image, "の拡張子はpng、jpg、jpegにして下さい。") unless profile_image.content_type.in?(extensions)
  end

  def was_attached?
    self.profile_image.attached?
  end

  #倫理削除されているとき、ログインできないようにする
  def active_for_authentication? #deviseにある機能。superで呼び出し、is_activeがtrueでなければログインできなくなる
    super && is_active?
  end

  #userによってフォローされているかどうかのチェック
  def followed_by?(current_user)
    followers.exists?(follower_id: current_user.id)#カレントユーザーにフォローされているfollowerか？
  end

  def following?(user)
    following_users.map(&:followed_id).include?(user.id)#フォローしているか判定
  end

  def follow(user)
    #following_usersは↑で定義した、followしたユーザーデータ(中間テーブルのみ）を取得するメソッド
    #中間テーブルのfollowedとfollowerにidをセットする？
    #other_userをフォローするために、followモデルに新しいデータを作成する
    #フォローされたユーザーidに選んだユーザーのidをセットしている。
    following_users.create(followed_id: user.id)
  end

  def unfollow(user)
    #userのidとfollowed_idが一致するデータを削除
    following_users.find_by(followed_id: user.id).destroy
  end

  def self.search_for(query,method)
    if query.blank?
      #Userモデル内で定義しているため、User.allをallに省略が可能。whereも同様
      return all
    end

    case method
    when "perfect"
      where(name: query)
    when "partial"
      where("name LIKE ?", "%#{query}%")
    else
      all
    end
  end


#画像取得メソッドの修正 attachedをattachに、引数を追加
#attachedは既にアタッチされているか？attachはファイル添付のメソッド
  def get_profile_image(height,width)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    #profile_imageがない場合、設定したファイルの位置の画像を呼び出し、保存
    profile_image.variant(resize_to_fill: [height, width, {gravity: "center"}]).processed
    #プロフィール画像を表示。variantは画像の加工のメソッド。processedはリサイズ処理を適応した状態を結果として返す。
  end

end