class ChargePolicy < ApplicationPolicy
  attr_reader :user, :charge

  def initialize(user, charge)
    @user = user
    @charge = charge
  end

  def destroy?
     unless user.present? && user.role == 'admin'
        false
     end
  end

end
