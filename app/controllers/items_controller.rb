class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]


  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    
  end

  def edit
    return unless current_user != @item.user
    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  private
  
  def set_item
    @item = Item.find(params[:id])
  end
  
  def item_params
    params.require(:item)
          .permit(:name, :description, :category_id, :condition_id, :shipping_method_id,
                  :prefecture_id, :days_to_ship_id, :price, :image)
          .merge(user_id: current_user.id)
  end
end
