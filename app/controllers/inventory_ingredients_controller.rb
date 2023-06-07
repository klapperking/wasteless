class InventoryIngredientsController < ApplicationController

  before_action :set_inventory, only: %i[new create]

  def new
    @inventory_ingredient = InventoryIngredient.new
    @inventory_ingredient.inventory = @inventory
    authorize @inventory_ingredient
  end

  def create
    @inventory_ingredient = InventoryIngredient.new(ingredient_params)
    @inventory_ingredient.inventory = @inventory
    authorize @inventory_ingredient
    if @inventory_ingredient.save
      redirect_to inventory_path(@inventory)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_inventory
    @inventory = Inventory.find(params[:inventory_id])
  end

  def ingredient_params
    params.require(:inventory_ingredient).permit(:quantity, :ingredient_id)
  end
end
