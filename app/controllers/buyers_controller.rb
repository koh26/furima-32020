class BuyersController < ApplicationController
  
  def index
    @buyer_address = BuyerAddress.new
  end

  def create
  end

end
