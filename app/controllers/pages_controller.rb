class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @ingredients = Ingredient.all
    @my_pets = { "Less than 2 days" => 12, "2 - 4 days" => 7, "5 - 7 days" => 5, "1 - 2 weeks" => 8, "2 - 4 weeks" => 13, "More than a month" => 6 }
  end
end
