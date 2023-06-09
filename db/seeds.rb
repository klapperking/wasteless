require 'json'
require 'date'

seed_resource_dir = "#{__dir__}/seed_resources/"

puts "Cleaning Database..."
Category.destroy_all
User.destroy_all
puts "Cleaned Database"
puts "---------------------------"

puts "Creating users..."
users_json = JSON.parse(File.read("#{seed_resource_dir}/users.json"))

users_json['users'].each do |user|
  attributes = {
    first_name: user['first_name'],
    last_name: user['last_name'],
    email: user['email'],
    password: user['password'],
    password_confirmation: user['password_confirmation'],
    admin: user['admin']
  }
  User.create!(attributes)
end
puts "Created #{User.count} users"
puts "---------------------------"

puts "Creating categories..."
category_ingredients_json = JSON.parse(File.read("#{seed_resource_dir}/categories_ingredients.json"))

# iterate category json
category_ingredients_json['categories_and_ingredients'].each do |category|
  # create the category
  category_attributes = {
    name: category['category_info']['name'],
    days_to_expiry: category['category_info']['days_to_expiry'],
    measuring_unit: category['category_info']['measuring_unit']
  }

  # attach icon to category from url
  new_category = Category.new(category_attributes)
  photo = URI.open(category['category_info']['icon_url'])
  new_category.icon.attach(io: photo, filename: category['category_info']['name'], content_type: 'image/png')

  new_category.save!

  # create each ingredient
  category['ingredients'].each do |ingredient|
    ingredient_attributes = {
      name: ingredient,
      category: Category.last
    }
    Ingredient.create!(ingredient_attributes)
  end
end
puts "Created #{Category.count} Categories and #{Ingredient.count} Ingredients"
puts "---------------------------"

puts "Creating recipes..."
recipes_json = JSON.parse(File.read("#{seed_resource_dir}/recipes.json"))

recipes_json['recipes'].each do |recipe|
  # read recipe attributes
  recipe_attributes = {
    name: recipe['name'],
    description: recipe['description'],
    number_of_people: recipe['number_of_people'],
    user: User.last
  }

  # attach photo to recipe from url
  new_recipe = Recipe.new(recipe_attributes)
  photo = URI.open(recipe['photo'])
  new_recipe.photo.attach(io: photo, filename: recipe['photo'][-20..], content_type: 'image/png')

  new_recipe.save!

  # create Ingredients for given Recipe
  recipe['recipe_ingredients'].each do |ingredient|
    recipe_ingredient_attrs = {
      quantity: ingredient['quantity'],
      ingredient: Ingredient.find_by(name: ingredient['name']),
      recipe: Recipe.last
    }
    RecipeIngredient.create!(recipe_ingredient_attrs)
  end
end
puts "Created #{Recipe.count} recipes"
puts "---------------------------"

puts "Populating Inventories..."
# add 10 ingredients to each inventory with randomized quantity and expiry date;
user_inventory_ingredients = JSON.parse(File.read("#{seed_resource_dir}/user_inventory_ingredients.json"))

user_inventory_ingredients['user_inventory_ingredients'].each do |user|
  # get user inventory
  for_user = User.find_by(email: user['user_email'])
  inventory = Inventory.find_by(user: for_user)

  # for each ingredient for that inventory create an IngredientInventory entry
  user['inventory_ingredients'].each do |ingredient|
    inv_ingr_attributes = {
      inventory:,
      ingredient: Ingredient.find_by(name: ingredient['name']),
      quantity: ingredient['quantity'],
      expiration_date: Date.parse(ingredient['expiration_date'])
    }

    InventoryIngredient.create!(inv_ingr_attributes)
  end
end
puts "Done"
puts "---------------------------"

puts "Faking Shopping List..."
user_shopping_list_ingredients = JSON.parse(File.read("#{seed_resource_dir}/user_shopping_list_ingredients.json"))

user_shopping_list_ingredients['user_shopping_list_ingredients'].each do |user|
  # get user inventory
  for_user = User.find_by(email: user['user_email'])
  shopping_list = ShoppingList.find_by(user: for_user)

  # for each ingredient for that inventory create an IngredientInventory entry
  user['shopping_list_ingredients'].each do |ingredient|
    sl_ingr_attributes = {
      shopping_list:,
      ingredient: Ingredient.find_by(name: ingredient['name']),
      quantity: ingredient['quantity']
    }

    ShoppingListIngredient.create!(sl_ingr_attributes)
  end
end
puts "Done"
puts "---------------------------"

puts "Finished seeding"
