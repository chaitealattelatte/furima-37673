class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @item = Item.all.order('created_at DESC')
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

  # def edit
  # @item = Item.find(params[:id])
  # unless user_signed_in? && current_user.id == @item.user.id
  # redirect_to action: :index
  # end
  # end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :charge_id, :source_id, :delivery_day_id,
                                 :price, :image).merge(user_id: current_user.id)
  end
end
