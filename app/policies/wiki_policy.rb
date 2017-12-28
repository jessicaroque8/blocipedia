class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
     true if wiki.private == false || wiki.user_id == user.id
  end

  def destroy?
     true if wiki.user_id == user.id
  end



  class Scope
     attr_reader :user, :scope

     def initialize(user, scope)
        @user  = user
        @scope = scope
     end

     def resolve
        if user.admin?
          scope.all
        elsif user.standard?
          scope.where(private: false)
        elsif user.premium?
          scope.where("private = ? OR user_id = ? AND private = ?", false, user.id, true)
        end
     end
  end

end
