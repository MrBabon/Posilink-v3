class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.admin? || user.director?
  end

  def edit
    user.admin? || user.director?
  end

  def update?
    user.admin? || user.director?
  end

  def destroy?
    user.admin? || user.director?
  end
  
  def show?
    true
  end
end
