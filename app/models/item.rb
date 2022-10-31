class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

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
  validates :price, numericality:  {with: /\A[0-9]+\z/, message: "is invalid. Input half-width characters." } 
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is out of setting range" }
  
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :schedule_delivery_id
    validates :prefecture_id
  end

end
