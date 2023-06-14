class InventoriesController < ApplicationController
  def show
    # get the inventory for current-user using policy
    @inventory = policy_scope(Inventory)
    authorize @inventory

    # if coming from camera button do something
    if params[:scan]
      barcode_prep()
    end

    @inventory_ingredients = @inventory.inventory_ingredients
    if params[:query].present?
      sql_subquery = <<~SQL
      ingredients.name ILIKE :query
      SQL
      @inventory_ingredients = @inventory_ingredients.joins(:ingredient).where(sql_subquery, query: "%#{params[:query]}%")
    end
    respond_to do |format| # Follow regular flow of Rails
      format.html
      format.text { render partial: "inventories/inventory_ingredients", locals: {inventory_ingredients: @inventory_ingredients}, formats: [:html]  }
    end

    # get a new inventory ingredient
    @inventory_ingredient = InventoryIngredient.new
    @inventory_ingredient.inventory = @inventory
  end

  def barcode_prep
    session[:new_scan] = true
    # if page is reloaded, dont trigger camera again
    if session.key?(:new_scan)
      @scan_reffered = session[:new_scan]
      session.delete(:new_scan)
    end
  end
end
