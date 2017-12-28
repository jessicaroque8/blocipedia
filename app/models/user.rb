class User < ApplicationRecord
   has_many :wikis
   before_create {self.role = :standard}

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

   enum role: [:admin, :standard, :premium]

   def self.admin?
      self.role = :admin ? true : false
   end

   def self.premium?
      self.role = :premium ? true : false
   end

end
