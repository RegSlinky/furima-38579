class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index

  def index
    @order = Order.new(order_params)
  end

  def new
    @order_destination = OrderDestination.new
  end

  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      @order_destination.save
      redirect_to root_path
    end
  end

  private

  def order_params
    params.require(:order_destination).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(item_id: item_id, user_id: current_user.id)
  end

  # def destination_params
  #   params.permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(order_id: @order.id)
  # end

  def move_to_index
    @item = Item.find(params[:item_id])
    if @item.user_id == current_user.id || @item.order != nil
      redirect_to root_path
    end
  end

end
