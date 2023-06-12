class RecipePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all.where(user:)
    end
  end

  def index?
    true
  end

  def show?
    record.user == user
  end

  def add_from_recipe?
    record.user == user
  end
end
