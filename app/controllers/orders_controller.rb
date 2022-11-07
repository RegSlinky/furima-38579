class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index

  def index
    @item = Item.find(params[:item_id])
    @order_destination = OrderDestination.new
  end

  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      pay_item
      @order_destination.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.require(:order_destination).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number,).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],  
      currency: 'jpy'               
    )
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    if @item.user_id == current_user.id || @item.order != nil
      redirect_to root_path
    end
  end

end
