class ShoppingListIngredientsController < ApplicationController

  def create
    @shopping_list = ShoppingList.find_by(user: current_user)
    @shopping_list_ingredient = ShoppingListIngredient.new(shopping_ingredient_params)
    @shopping_list_ingredient.shopping_list = @shopping_list
    authorize @shopping_list_ingredient
    if @shopping_list_ingredient.save
      redirect_to shopping_list_path(@shopping_list)
    else
      render `shopping_lists/#{@shopping_list}`, status: :unprocessable_entity
    end
  end

  def update
    @shopping_list = ShoppingList.find_by(user: current_user)
    @shopping_list_ingredient = ShoppingListIngredient.find(params[:id])
    authorize @shopping_list_ingredient
    if params[:shopping_list_ingredient][:quantity].to_i <= 0
      @shopping_list_ingredient.destroy
      redirect_to shopping_list_path(@shopping_list)
    else
      @shopping_list_ingredient.update(shopping_ingredient_params)
      if @shopping_list_ingredient.save
        redirect_to shopping_list_path(@shopping_list)
      else
        render `shopping_lists/#{@shopping_list}`, status: :unprocessable_entity
      end
    end
  end

  private

  def set_shopping_list
    @shopping_list = ShoppingList.find(params[:shopping_list_id])
  end

  def shopping_ingredient_params
    params.require(:shopping_list_ingredient).permit(:ingredient_id, :quantity)
  end
end
