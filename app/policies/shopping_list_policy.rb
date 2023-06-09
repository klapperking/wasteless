class ShoppingListPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
  end

  def show?
    record.user == user
  end
end
