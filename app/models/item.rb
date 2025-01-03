class Item < ApplicationRecord
  belongs_to :user 

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :courts
  def sold_out?
    courts.exists? # 誰かがこの投稿をカートに追加している場合に true を返す
  end

  has_many :comments, dependent: :destroy

  has_one_attached :image

  has_many :item_tag_relations, dependent: :destroy
  has_many :tags, through: :item_tag_relations, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["title", "body", "price", "created_at", "updated_at", "id", "comments", "tags", "user"]
  end
end
