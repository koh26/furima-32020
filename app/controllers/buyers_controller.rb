class BuyersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @items = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @items.user.id || @items.buyer.present?
    @buyer_address = BuyerAddress.new
  end

  def create
    @items = Item.find(params[:item_id])
    @buyer_address = BuyerAddress.new(buyer_params)
    if @buyer_address.valid?
      pay_item
      @buyer_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def buyer_params
    params.require(:buyer_address).permit(:postal_code, :prefecture_id, :city, :number, :building, :tel).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @items.price,
      card: buyer_params[:token],
      currency: 'jpy'
    )
  end
end
