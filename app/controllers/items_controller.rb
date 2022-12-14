class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :move_to_index, except: [:index, :new, :create, :show, :destroy]
  
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
  end

  def edit
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to item_path(@item.id), method: :get
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    if current_user.id == item.user.id
      item.destroy
    end
    redirect_to action: :index
  end

  private

  def item_params
    params.require(:item).permit(:image, :item, :item_text, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :schedule_delivery_id, :price).merge(user_id:current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    unless current_user.id == @item.user.id && @item.order == nil
      redirect_to action: :index
    end
  end

end
