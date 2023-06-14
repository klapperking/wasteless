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

  def edit
    @inventory_ingredient = InventoryIngredient.find(params[:id])
    authorize @inventory_ingredient
  end

  def update
    @inventory = Inventory.find_by(user: current_user)
    @inventory_ingredient = InventoryIngredient.find(params[:id])
    authorize @inventory_ingredient
    if params[:inventory_ingredient][:quantity].to_i <= 0
      @inventory_ingredient.destroy
    else
      @inventory_ingredient.update(ingredient_params)
      @inventory_ingredient.save
    end
    redirect_to inventory_path(@inventory)
  end

  def destroy
    @inventory_ingredient = InventoryIngredient.find(params[:id])
    authorize @inventory_ingredient
    @inventory_ingredient.destroy
    redirect_to inventory_path(@inventory_ingredient.inventory), status: :see_other
  end

  def modify
    @inventory = Inventory.find_by(user: current_user)
    @shopping_list = ShoppingList.find_by(user: current_user)
    ingredients = params["_json"]
    ids = @inventory.inventory_ingredients.pluck(:ingredient_id)
    ingredients.each do |ingredient|
      if ids.include?(ingredient[:ingredient_id].to_i)
        @inventory_ingredient = @inventory.inventory_ingredients.find_by(ingredient_id: ingredient[:ingredient_id])
        @inventory_ingredient.update!(quantity: ingredient[:ingredient_qty])
        @shopping_list_ingredient = @shopping_list.shopping_list_ingredients.find_by(ingredient_id: ingredient[:ingredient_id])
        @shopping_list_ingredient.destroy
      else
        InventoryIngredient.create!(inventory_id: @inventory.id, ingredient_id: ingredient[:ingredient_id], quantity: ingredient[:ingredient_qty])
        @shopping_list_ingredient = @shopping_list.shopping_list_ingredients.find_by(ingredient_id: ingredient[:ingredient_id])
        @shopping_list_ingredient.destroy
      end
    end
    authorize @inventory_ingredient
    respond_to do |format|
      format.json { render json: { status: 'ok', id: @inventory.id } }
    end
    # respond_to do |format|
    #   format.html { redirect_to inventory_path(@inventory) }
    # end
  end

  private

  def set_inventory
    @inventory = Inventory.find(params[:inventory_id])
  end

  def ingredient_params
    params.require(:inventory_ingredient).permit(:quantity, :ingredient_id)
  end
end
