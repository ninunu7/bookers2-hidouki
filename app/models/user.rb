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
  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  #ユーザーが投稿に対して既にいいねしているか
  def already_liked?(book)
    favorites.exists?(book_id: book.id)
  end
end
