class BuyerAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :number, :building, :buyer_id, :tel, :token

  with_options presence: true do
    validates :user_id
    validates :item_id

    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :number
    validates :tel, format: { with: /\A\d{11}\z/ }
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    # バイヤーの情報を保存し、「buyer」という変数に入れている
    buyer = Buyer.create(item_id: item_id, user_id: user_id)
    # 住所の情報を保存
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, number: number, tel: tel, building: building, buyer_id: buyer.id)
  end
end
