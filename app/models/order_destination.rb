class OrderDestination
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :token
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "を「3桁ハイフン4桁」の半角文字を入力してください"}
    validates :city
    validates :address
    validates :phone_number, format: {with: /\A\d{10,11}\z/, message: "を「10桁以上、11桁以内」の半角数字を入力してください"}
    validates :item_id
    validates :user_id
  end
  
  with_options numericality: { other_than: 1, message: "を入力してください" } do
    validates :prefecture_id
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Destination.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, order_id: order.id)
  end

end