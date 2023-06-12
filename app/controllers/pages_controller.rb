class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @inventory = Inventory.find(current_user.id)
    @recipe = Recipe.last
    @ingredients = @inventory.inventory_ingredients
    @my_ingredients = { "Less than 2 days" => @ingredients.select { |ingredient| ingredient.expiration_date <= Date.today + 2}.count,
     "2 - 4 days" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 2 && ingredient.expiration_date <= Date.today + 4}.count,
     "5 - 7 days" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 4 && ingredient.expiration_date <= Date.today + 7}.count,
     "1 - 2 weeks" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 7 && ingredient.expiration_date <= Date.today + 14}.count,
     "2 - 4 weeks" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 14 && ingredient.expiration_date <= Date.today + 30}.count,
     "More than a month" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 30}.count }
  end

  def confirmation
    @recipe = Recipe.find(6)
    @inventory = Inventory.find(current_user.id)
    @ingredients = []
    @inventory.inventory_ingredients.each do |ingredient|
      @ingredients << ingredient.ingredient_id
    end
  end
end
