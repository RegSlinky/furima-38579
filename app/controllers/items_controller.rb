class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, except: [:index, :new, :create, :show]
  
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item =  Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to item_path(@item.id), method: :get
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item, :item_text, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :schedule_delivery_id, :price).merge(user_id:current_user.id)
  end

  def move_to_index
    @item = Item.find(params[:id])
    @user = @item.user
    unless user_signed_in? && current_user.id == @user.id
      redirect_to action: :index
    end
  end

end
