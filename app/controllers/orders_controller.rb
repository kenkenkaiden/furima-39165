class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_set, only:[:index, :create]

  def index
    if (current_user == @item.user) || (Order.exists?(item_id: @item.id))
      redirect_to root_path
    end

    @order_address = OrderAddress.new
  end


  def create
    @order_address = OrderAddress.new(order_params)
    @order_address.user_id = current_user.id
    @order_address.item_id = @item.id

    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def item_set
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture, :city, :street_address, :building_name,
                                          :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
