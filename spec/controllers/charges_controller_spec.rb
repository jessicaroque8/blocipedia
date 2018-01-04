require 'rails_helper'
require 'stripe_mock'

RSpec.describe ChargesController, type: :controller do

  let(:my_user) { create(:user) }
  let(:stripe_helper) { StripeMock.create_test_helper }

  before { StripeMock.start }
  before { allow(controller).to receive(:current_user) { my_user } }
  after { StripeMock.stop }

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to redirect_to('users/settings')
    end

    it "creates a new customer" do
      customer = Stripe::Customer.create(
        email: my_user.email,
        card: stripe_helper.generate_card_token
      )
       expect(customer.email).to eq (my_user.email)
    end

    it "creates a new charge" do
      customer = Stripe::Customer.create(
         email: my_user.email,
         card: stripe_helper.generate_card_token
      )

      charge = Stripe::Charge.create(
          customer: customer.id,
          amount: Amount.new(value: 5_00).value,
          description: "Premium Membership - #{my_user.email}",
          currency: 'usd'
       )
       expect(response).to have_http_status(:success)
    end

    it "redirects to the settings page" do
       get :create
       expect(response).to redirect_to('users/settings')
    end

    it "changes current_user.role to premium" do
      get :create
      expect(my_user.role).to eql('premium')
    end
  end

end
