class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :street_address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :street_address
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'は、10桁以上11桁以内の半角数値で入力してください。' }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    # 住所を保存する
    Address.create(
      postal_code: postal_code,
      prefecture: prefecture,
      city: city,
      street_address: street_address,
      building_name: building_name,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end
