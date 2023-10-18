class OrganizationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user.admin?
  end

  def create_event?
    user.admin? || (user.director? && user.organizations.include?(record))
  end

  def edit?
    user.admin? || user.director?
  end

  def update?
    user.directors.exists?(organization: record)
  end

  def index?
    true
  end

  def show?
    true
  end
end
