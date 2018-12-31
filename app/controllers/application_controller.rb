class ApplicationController < ActionController::Base


before_action :current_cart
helper_method :current_cart
#create a helper method so that we can use it in our views 

  def current_cart
    #if the customer has just landed on the site, give them a brand new cart_id
    #if they already have one, keep it
    #check sesion[:cart_id]

    if session[:cart_id].present?
      #they already have a cart-great!
      @current_cart= Cart.find(session[:cart_id])
    else
      @current_cart= Cart.create
      #create means new and save together
      session[:cart_id]= @current_cart.id
    end

  end
end
