class ShoppingListsController < ApplicationController
  before_action :recipe_params, only: %i[add_recipe]

  def show
    # get shopping list of current user
    @shopping_list = ShoppingList.find(params[:id])

    # get all the ingredients of that shopping list
    @shoppinglist_ingredients = @shopping_list.shopping_list_ingredients
    @ingredients = @shopping_list.ingredients

    # get all categories for each of the referenced ingredients
    @categories = []

    @shoppinglist_ingredients.each do |shop_ingredient|
      category_name = shop_ingredient.ingredient.category.name
      @categories.push(category_name) unless @categories.include?(category_name)
    end

    # possibly missing auth for other view-vars?
    authorize @shopping_list
  end

  def add_recipe
    @recipe = Recipe.find(recipe_params[:id])

    @recipe_ingredients = RecipeIngredient.where(recipe: @recipe) # TODO: Recipe doesn't have a user attached right now

    # for each ingredient find, if it can be found in inventory - substract quantities
    # create a shoppinglist_ingredient of difference; maintain amount used and amount necessary
    # pass on to confirm page

    to_update_in_inventory = {}
    to_add_to_shopping_list = {}

    # for each ingredient require - check if user needs to shop it and or add/substract quantities
    @recipe_ingredients.each do |recipe_ingredient|
      # attempt to find ingredient in user inventory
      user_inventory_ingredient = InventoryIngredient.find_by(
        ingredient_id: recipe_ingredient.ingredient_id,
        inventory_id: Inventory.find_by(user: current_user) # unclear if necessary or handled by pundit already
      )

      # if user does not have it: Add full qunatity to shopping list and go to next ingredient
      unless user_inventory_ingredient
        to_add_to_shopping_list[recipe_ingredient.ingredient_id] = recipe_ingredient.quantity
        next
      end

      # user has ingredient: Get difference and add accordingly
      quantity_difference = recipe_ingredient.quantity - user_inventory_ingredient.quantity

      # if user has more than needed, just substract form inventory
      if quantity_difference.negative? || quantity_difference.zero?
        to_update_in_inventory[recipe_ingredient.ingredient_id] = recipe_ingredient.quantity
        next
      end

      # if user needs more than they currently have, add to shopping list and substract from inventory
      to_update_in_inventory[recipe_ingredient.ingredient_id] = recipe_ingredient.quantity
      to_add_to_shopping_list[recipe_ingredient.ingredient_id] = quantity_difference
    end

    ## update shoppinglist and inventory; then redirect to confirmation page

    # shopping_list
    to_add_to_shopping_list.each do |ingredient_id, quantity|
      # if entry for ingredient exists, update it with quantity
      existing_entry = ShoppingListIngredient.find(ingredient_id:, shopping_list: ShoppingList.find_by(user: current_user))
      if existing_entry
        existing_entry.update!(quantity: existing_entry.quantity + quantity)
      # if doesnt exist create it
      else
        new_entry = ShoppingListIngredient.new(
          ingredient_id:,
          quantity:,
          shopping_list: ShoppingList.find_by(user: current_user)
        )
        new_entry.save!
      end
    end

    # inventory
    to_update_in_inventory.each do |ingredient_id, quantity|
      user_inventory_ingredient = InventoryIngredient.find_by(
        ingredient_id:,
        inventory_id: Inventory.find_by(user: current_user) # unclear if necessary or handled by pundit already
      )

      new_quantity = user_inventory_ingredient.quantity - quantity

      # destroy ingredients that will be gone completely
      # negative case is handled above already
      unless new_quantity.positive?
        user_inventory_ingredient.destroy!
        next
      end

      # otherwise update quantities
      user_inventory_ingredient.update!(quantity: new_quantity)
    end

    authorize @recipe
    redirect_to(
      recipe_confirmation_path(
        recipe: @recipe,
        inventory: to_update_in_inventory,
        shopping_list: to_add_to_shopping_list
      )
    )
  end

  private

  def recipe_params
    # permit shoppinglist-id and recipe-id
    params.permit(:shopping_list_id, :id)
  end
end
