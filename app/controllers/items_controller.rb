class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :id_params, only: [:show, :edit, :update, :destroy]
  before_action :redirect, only: [:edit, :destroy]

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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def redirect
    redirect_to root_path if user_signed_in? && current_user.id != @item.user.id
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :charge_id, :source_id, :delivery_day_id,
                                 :price, :image).merge(user_id: current_user.id)
  end

  def id_params
    @item = Item.find(params[:id])
  end
end
