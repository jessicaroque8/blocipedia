class Collaborator < ApplicationRecord
   belongs_to :user
   belongs_to :wiki

   validates :user_id, uniqueness: { scope: :wiki_id, :message => "can only be added as a collaborator to a wiki once." }

   def get_user
      User.find_by(id: self.user_id)
   end

   def get_wiki
      Wiki.find_by(id: self.wiki_id)
   end
end
