class BuyersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @items = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @items.user.id
    @buyer_address = BuyerAddress.new
  end

  def create
    
    @buyer_address = BuyerAddress.new(buyer_params)
     if @buyer_address.valid?
      @buyer_address.save
       redirect_to root_path
     else
      
      @items = Item.find(params[:item_id])

      render action: :index
     end
  end
 
  private
  def buyer_params
   params.require(:buyer_address).permit(:postal_code, :prefecture_id, :city, :number, :building, :tel).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
