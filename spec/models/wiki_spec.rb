require 'rails_helper'
require 'random_data'

RSpec.describe Wiki, type: :model do
   let(:my_user) { create(:user) }
   let(:my_wiki) { create(:wiki, user: my_user) }

   it {is_expected.to belong_to(:user)}

   describe "attributes" do
      it "has a title, body, and user attribute" do
         expect(my_wiki).to have_attributes(title: my_wiki.title, body: my_wiki.body, user: my_wiki.user)
      end
   end

end
