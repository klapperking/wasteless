require 'json'
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
  Category.create!(category_attributes)

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
    user: User.all.sample
  }

  # attach photo to recipe from url
  new_recipe = Recipe.new(recipe_attributes)
  photo = URI.open(recipe['photo'])
  new_recipe.photo.attach(io: photo, filename: recipe['photo'][-20..], content_type: 'image/png')

  new_recipe.save!

  # create Ingredients for given Recipe
  recipe['recipe_ingredients'].each do |ingredient|
    puts ingredient
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

puts "Done"
puts "---------------------------"

puts "Populating Shopping Lists..."

puts "Done"
puts "---------------------------"

puts "Finished seeding"
