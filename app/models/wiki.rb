class Wiki < ApplicationRecord
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  accepts_nested_attributes_for :collaborators, allow_destroy: true

  before_create :set_default

  def owner_id
     owner = Collaborator.find_by(wiki_id: self.id, owner: true)
     owner.nil? ? false : owner.user_id
  end

  def owner
     self.owner_id == false ? false : User.find(self.owner_id)
  end

  def public?
     self.private == false ? true : false
  end

  private

  def set_default
     self.private = false if self.private.nil?
  end

end
