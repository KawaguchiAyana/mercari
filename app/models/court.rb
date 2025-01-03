class Court < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :item_id, uniqueness: { scope: :user_id, message: "この商品は既にカートに追加されています。" }


end
