class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :item_params, only: [:index, :create]

  def index
    redirect_to root_path if current_user.id == @item.user.id || @item.order.present?
    @purchasers_order = PurchasersOrder.new
  end

  def create
    @purchasers_order = PurchasersOrder.new(purchasers_params)
    if @purchasers_order.valid?
      pay_item
      @purchasers_order.save # ここで初めてorder_idができる
      redirect_to root_path
    else
      render :index
    end
  end

  def item_params
    @item = Item.find(params[:item_id])
  end

  private

  def purchasers_params
    params.require(:purchasers_order).permit(:post_code, :source_id,
                                             :city, :address, :building, :phone).merge(item_id: @item.id, user_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchasers_params[:token],
      currency: 'jpy'
    )
  end
end
