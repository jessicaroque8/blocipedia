class UsersController < ApplicationController

   def edit
      @stripe_btn_data = {
          key: "#{Rails.configuration.stripe[:publishable_key]}",
          description: "Premium Membership - #{current_user.email}",
          amount: Amount.new(value: 5_00).value
       }
   end

   def set_role_standard
      @user = current_user
      @user.role = :standard
      @user.save

      if @user.save
        flash[:notice] = "Your account type has been changed to standard."
        redirect_back(fallback_location: 'users/settings')
     else
        flash.now[:alert] = "There was an error when trying to change your account type. Please try again."
        render :edit
     end
   end

# currently not being used anywhere
   def set_role_premium
      @user = current_user
      @user.role = :premium
      @user.save

      if @user.save
        flash[:notice] = "Your account type has been changed to premium."
        redirect_back(fallback_location: 'users/settings')
     else
        flash.now[:alert] = "There was an error when trying to change your account type. Please try again."
        render :edit
     end
   end

end
