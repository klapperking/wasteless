class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @inventory = Inventory.find(current_user.id)
    @recipe = Recipe.last
    @my_pets = { "Less than 2 days" => 12, "2 - 4 days" => 7, "5 - 7 days" => 5, "1 - 2 weeks" => 8, "2 - 4 weeks" => 13, "More than a month" => 6 }
  end

  def confirmation
    @recipe = Recipe.first
    @inventory = Inventory.find(current_user.id)
    @ingredients = []
    @inventory.inventory_ingredients.each do |ingredient|
      @ingredients << ingredient.ingredient_id
    end
  end
end
