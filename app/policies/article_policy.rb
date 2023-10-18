class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user.admin? || user.director?
  end

  def create?
    user.admin? || user.director?
  end

end
