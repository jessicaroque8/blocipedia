require 'rails_helper'
require 'random_data'

RSpec.describe Wiki, type: :model do
   let(:my_user) { create(:user) }
   let(:my_wiki) { create(:wiki) }
   let(:current_user) {:my_user}

   it {is_expected.to have_many(:collaborators)}
   it {is_expected.to have_many(:users)}

   # before { allow(model).to receive(:current_user) { my_user } }

   describe "attributes" do
      it "has a title, body" do
         expect(my_wiki).to have_attributes(title: my_wiki.title, body: my_wiki.body)
      end
   end

   describe "defaults" do
      it "sets private to false if value is not provided by user" do
         expect(my_wiki.private?).to be_falsey
      end
   end

end
