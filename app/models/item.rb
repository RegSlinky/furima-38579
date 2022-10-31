class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status_id
  belongs_to :shipping_fee_status_id
  belongs_to :schedule_delivery_id
  belongs_to :refecture_id

  validates :item, :price,:item_text, presence: true
  validates :category_id, :sales_status_id, :shipping_fee_status_id, :schedule_delivery_id, :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}

end
