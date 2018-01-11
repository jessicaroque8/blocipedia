class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def show?
     true if wiki.private == false || wiki.owner == user || wiki.collaborators.where(user_id: user.id).present?
  end

  def edit?
     true if wiki.private == false || wiki.owner == user || wiki.collaborators.where(user_id: user.id).present?
  end

  def destroy?
     true if wiki.owner == user || user.admin?
  end

  class Scope
     attr_reader :user, :scope

     def initialize(user, scope)
       @user = user
       @scope = scope
     end

     def resolve
         wikis = []
         if user.nil?
            all_wikis = scope.all
            all_wikis.each do |wiki|
               if wiki.public?
                  wikis << wiki
                end
             end
         elsif user.role == 'admin'
            wikis = scope.all
         elsif user.role == 'premium'
            all_wikis = scope.all
            all_wikis.each do |wiki|
              if wiki.public? || wiki.owner == user || wiki.collaborators.where(user_id: user.id).present?
                wikis << wiki
              end
            end
         else
            all_wikis = scope.all
            wikis = []
            all_wikis.each do |wiki|
              if wiki.public? || wiki.collaborators.where(user_id: user.id).present?
                wikis << wiki
              end
            end
         end

         wikis
     end

  end

end
