class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_items, through: :likes, source: :item

  def already_liked?(item)
    self.likes.exists?(item_id: item.id)
  end

  has_many :courts, dependent: :destroy
  has_many :courted_items, through: :courts, source: :item

  has_many :courts
  has_many :court_items, through: :courts, source: :item

  has_many :comments, dependent: :destroy

  has_many :tweets, dependent: :destroy #追記 ユーザーが削除されたら、ツイートも削除されるようになります。すでに書いてある場合は追記しなくて大丈夫です。
  validates :name, presence: true #追記
  validates :profile, length: { maximum: 200 } #追記

  has_one_attached :image 

end
