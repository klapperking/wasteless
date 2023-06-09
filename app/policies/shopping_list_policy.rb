class ShoppingListPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all.find_by(user:)
    end
  end

  def show?
    true
  end
end
