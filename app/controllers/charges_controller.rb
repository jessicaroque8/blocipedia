class ChargesController < ApplicationController

   def create
     customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken]
      )

     charge = Stripe::Charge.create(
        customer: customer.id,
        amount: Amount.new(value: 5_00).value,
        description: "Premium Membership - #{current_user.email}",
        currency: 'usd'
      )

     current_user.role = :premium
     current_user.save
     flash[:notice] = "Thanks for upgrading your account, #{current_user.email}! Enjoy the fancy life."
     redirect_back(fallback_location: 'users/settings')

     rescue Stripe::CardError => e
        flash[:alert] = e.message
        redirect_to users_settings
   end



end
