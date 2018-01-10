require 'rails_helper'

RSpec.describe Collaborator, type: :model do

   it {is_expected.to belong_to(:wiki)}
   it {is_expected.to belong_to(:user)}

   let(:my_wiki) {create(:wiki)}
   let(:my_user_owner) {create(:user)}
   let(:my_collaborator) { Collaborator.new(wiki_id: my_wiki.id, user_id: my_user_owner.id, owner: true) }

   describe "attributes" do
      it "responds to wiki_id, user_id, and owner" do
         expect(my_collaborator).to have_attributes(wiki_id: my_wiki.id, user_id: my_user_owner.id, owner: true)
      end
   end

end
