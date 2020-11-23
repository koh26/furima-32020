class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :day

  with_options presence: true do
    validates :image
    validates :title
    validates :about

    validates :price, format: { with: /\A[0-9]+\z/ },inclusion: { in: 300..9999999 }

  end

  with_options numericality: { other_than: 1 }  do
    validates :category_id
    validates :status_id
    validates :fee_id
    validates :prefecture_id
    validates :day_id
  end
  
end