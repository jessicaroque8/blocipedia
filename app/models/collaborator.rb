class Collaborator < ApplicationRecord
   belongs_to :user
   belongs_to :wiki

   validates :user_id, uniqueness: { scope: :wiki_id, :message => "can only be added as a collaborator to a wiki once." }, presence: true
end
