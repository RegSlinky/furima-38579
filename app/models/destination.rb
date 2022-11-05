class Destination < ApplicationRecord
  belongs_to :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  # validates :city, presence: true
  # validates :address, presence: true

  # validates :postal_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  # validates :phone_number, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 10, less_than_or_equal_to: 11, message: "is invalid"}
  
  # with_options numericality: { other_than: 1, message: "can't be blank" } do
  #   validates :prefecture_id
  # end

end
