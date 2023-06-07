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

puts "Created #{Recipes.count}"
puts "---------------------------"

puts "Populating Inventories..."

puts "Done"
puts "---------------------------"

puts "Populating Shopping Lists..."

puts "Done"
puts "---------------------------"

puts "Finished seeding"
