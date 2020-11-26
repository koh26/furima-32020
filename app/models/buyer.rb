class Buyer < ApplicationRecord

  belongs _to :item
  belongs_to :user
  has_one :address
  
end
