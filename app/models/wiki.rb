class Wiki < ApplicationRecord
  belongs_to :user
  after_initialize :set_defaults

  def set_defaults
     self.private = false if self.private.nil?
  end
end
