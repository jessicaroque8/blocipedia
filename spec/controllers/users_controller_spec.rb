require 'rails_helper'

RSpec.describe UsersController, type: :controller do

   let(:my_user) { create(:user) }

   before { allow(controller).to receive(:current_user) { my_user } }

   describe 'GET edit' do
      it "returns http success" do
         get :edit
         expect(response).to have_http_status(:success)
      end

      it "instantiates stripe_btn_data" do
         get :edit
         expect(assigns(:stripe_btn_data)).to_not be_nil
      end
   end
end
