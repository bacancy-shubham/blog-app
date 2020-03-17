class PaymentController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user.email
  end
  
  def new
    @payments = Payment.all   
  end
  
  def create
    # Amount in cents       
    @rupee =  params[:payment][:amount].to_i 
    @amount  = @rupee*100    
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
    @pay = Payment.create(email:params[:stripeEmail], amount: @amount)
    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'inr', 
    })   
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
