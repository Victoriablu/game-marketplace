class OrdersController < ApplicationController
     def index
    if current_user != nil

      if current_user.is_vendor? == true 
        @total_sales = 0
        @vendor_orders = Order.all
        @vendor_order_items = OrderItem.where(pending: false, vendor_id: current_user.vendor.id)
        @orders_belonging_to_vendor = []
        @vendor_order_items.each do |item|
          if item.vendor.id == current_user.vendor.id 
            @orders_belonging_to_vendor << item.order.id
          end
        end
        if @vendor_order_items.count == 0 
          flash[:alert] = "No orders belonging to this account exists."
          redirect_to root_path
        end
      else
        @orders = current_user.orders
        if @orders.count == 0 
        flash[:alert] = "No orders belonging to this account exists."
        redirect_to root_path
        end
      end
    end
  end

  def create
    @user = User.find(current_user.id)
    @order = Order.new(user_id: current_user.id)
    @order_items = OrderItem.where(user_id: current_user.id, pending: true)
    @total_price = 0
    @order_items.each do |item|
      @total_price += item.product.price * item.quantity
      item.update(pending: false)
      @order.order_items << item
    end
    
    @order.update(total_price: @total_price, completed: false)

    if @order.save
      render :show
    else
      render :new
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to @order
    else 
      render 'edit'
    end
  end

  def new
    @order = Order.new(user_id: current_user.id)
  end

  def edit
    @order = Order.find(params[:id])
  end

  def show
    @order = OrderItem.find(user_id: current_user.id)
    @user = User.find(current_user.id)
  end

  private
  def order_params
    params.permit(:total_price, :beer)
  end
end
