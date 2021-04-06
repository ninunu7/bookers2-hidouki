class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  #has_many :favorite_users, through: :favorites, source: :user
  has_many :favorite_books, through: :favorites, source: :user


  # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  has_many :following_user, through: :follower, source: :followed
   # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  has_many :follower_user, through: :followed, source: :follower


  attachment :profile_image, destroy: false
  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  #ユーザーが投稿に対して既にいいねしているか
  def already_liked?(book)
    favorites.exists?(book_id: book.id)
  end

    # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  def self.search(search,word)
    case search
      when 'forward_match'
         @user = User.where("name LIKE?","#{word}%")
      when "backward_match"
         @user = User.where("name LIKE?","%#{word}")
      when "perfect_match"
         @user = User.where("#{word}")
      when "partial_match"
         @user = User.where("name LIKE?","%#{word}%")
      else
         @user = User.all
    end
  end
  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
end
