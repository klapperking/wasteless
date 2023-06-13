class InventoriesController < ApplicationController
  def show
    # get the inventory for current-user using policy
    @inventory = policy_scope(Inventory)
    authorize @inventory
    @inventory_ingredients = @inventory.inventory_ingredients
    if params[:query].present?
      sql_subquery = <<~SQL
        ingredients.name ILIKE :query
      SQL
      @inventory_ingredients = @inventory_ingredients.joins(:ingredient).where(sql_subquery, query: "%#{params[:query]}%")
    end
  end
end
