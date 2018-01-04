class Wiki < ApplicationRecord
  belongs_to :user
  before_create :set_defaults

  def set_defaults
     self.private = false if self.private.nil?
  end
end
