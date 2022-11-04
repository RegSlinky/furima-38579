class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
  end

  def create
  end
end
