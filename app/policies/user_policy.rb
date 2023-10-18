class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end


  def show?
    true
  end

  def my_events?
    true    
  end

  def update?
    user.admin? || user == record
  end
  
  def edit?
    true
  end
end
