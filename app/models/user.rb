class User < ApplicationRecord
   has_many :wikis
   after_initialize {self.role = :standard}

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

   enum role: [:admin, :standard, :premium]

   def set_role_admin
      self.role = :admin
   end

   def set_role_standard
      self.role = :standard
   end

   def set_role_premium
      self.role = :premium
   end
   
end
