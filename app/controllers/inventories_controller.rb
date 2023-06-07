class InventoriesController < ApplicationController

  def show
    @inventory = Inventory.find(params[:id])
    authorize @inventory
  end
end
