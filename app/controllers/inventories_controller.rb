class InventoriesController < ApplicationController

  def index
    @inventory = Inventory.find_by(user: current_user)
    @ingredients = @inventory.ingredients
  end

  def new
  end

  def create
  end
end