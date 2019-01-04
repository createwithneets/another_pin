class Order < ApplicationRecord
  has_many :order_items


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :country, presence: true


accepts_nested_attributes_for :order_items

  def add_from_cart(cart)
    cart.order_items.all.each do |item|
      self.order_items.new(product: item.product, quantity: item.quantity)
      #for each item in the cart, take the cart and add it to the order itself including the item product and the quantity
    end

  end




  def save_and_charge
#check our data (the form info) is valid
#if it is, charge in stripe
#if it isn't, then return false
#charge in stripe and save if all good

if self.valid?

  Stripe::Charge.create(amount: self.total_price, currency: "usd",
  source: self.stripe_token, description: "Order for" + self.email)

  self.save

else
  # if the for mdoesn't pass validations, we don't want to charge it to stripe
  false
end

rescue Stripe::CardError => e
  #this is from stripe
  @message = e.json_body[:error][:message]
#add to the model errors
  self.errors.add(:stripe_token, @message)
#return false to our controller
  false

  end




  def total_price
    @total= 0
    order_items.each do |item|
      @total= @total + item.product.price * item.quantity
    end

    @total
  end



  def total_price_in_dollars
    @total= 0
      order_items.all.each do |item|
  @total= @total + item.product.price_in_dollars * item.quantity

      end

    @total
  end


end
