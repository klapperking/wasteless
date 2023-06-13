class InventoryIngredientPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    record.inventory.user == user
  end

  def update?
    record.inventory.user == user
  end

  def destroy?
    record.inventory.user == user
  end

  def modify?
    true
  end

  def show?
    true
  end

end
