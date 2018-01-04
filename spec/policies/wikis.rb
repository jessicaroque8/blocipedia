require 'pundit/rspec'

RSpec.describe WikiPolicy do

   subject { described_class }

   permission :index? do
      it "grants access to guest users" do
         expect(subject).to permit(Wiki.new)
      end
   end


end
