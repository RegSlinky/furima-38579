class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @order = Order.new(order_params)
  end

  def new
  end

  def create
    @order = Order.create(order_params)
    Destination.create(destination_params)
    redirect_to root_path
  end

  private

  def order_params
    params.permit(:item_id).merge(user_id: current_user.id)
  end

  def destination_params
    params.permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(order_id: @order.id)
  end

end
