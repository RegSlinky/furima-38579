class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :schedule_delivery
  belongs_to :prefecture

  validates :item, presence: true
  validates :image, presence: true 
  validates :item_text, presence: true

  validates :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "を¥300~¥9,999,999の間の半角数字を入力してください" }
 
  with_options numericality: { other_than: 1, message: "を入力してください" } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :schedule_delivery_id
    validates :prefecture_id
  end

end
