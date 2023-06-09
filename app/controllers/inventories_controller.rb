class InventoriesController < ApplicationController
  def show
    # get the inventory for current-user using policy
    @inventory = policy_scope(Inventory)
    authorize @inventory
  end
end
