require 'pundit/rspec'

RSpec.describe WikiPolicy do

   subject { WikiPolicy.new(user, wiki) }

   let(:wiki) { create(:wiki) }

   context "for a user not logged in" do
    let(:user) { nil }

    it { should     permit(:show)    }
    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not permit(:update)  }
    it { should_not permit(:edit)    }
    it { should_not permit(:destroy) }
  end


end
