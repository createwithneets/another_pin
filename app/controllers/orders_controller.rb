class OrdersController < ApplicationController

#this is the page that we see
  def new

    @order= Order.new
    @order.add_from_cart(@current_cart)
  end

#this is the actual action of creating a new line in the database
def create
  @order= Order.new(form_params)
@order.add_from_cart(@current_cart)
#this means that it adds the things from teh cart, as well as what was filled out in the form

  if @order.save_and_charge
    reset_session
    flash[:success] = "Order Completed"

    OrderMailer.receipt(@order).deliver_now


    redirect_to order_path(@order)
    #this goes to show page aka the thank you page
  else
    render "new"
    #show the same form with errors
end
end


def show

  @order= Order.find(params[:id])
end


  def form_params
    params.require(:order).permit(:first_name, :last_name, :email,
    :address_1, :address_2, :country, :city, :postal_code, :stripe_token)
  end

end
