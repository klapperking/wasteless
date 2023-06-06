puts "Cleaning database..."
Category.destroy_all
Ingredient.destroy_all
User.destroy_all

puts "Creating users..."

florian = { first_name: "Florian", last_name: "Guerin", email: "florian@wasteless.es", password: "123456", password_confirmation: "123456", admin: true }
martin = { first_name: "Martin", last_name: "Klapper", email: "martin@wasteless.es", password: "123456", password_confirmation: "123456", admin: false }

[florian, martin].each do |attributes|
  user = User.create!(attributes)
  puts "Created #{user.first_name}"
end

puts "Creating categories..."
fish_seafood = { name: "Fish and seafood", days_to_expiry: 4, measuring_unit: "g" }
meat = { name: "Meat", days_to_expiry: 6, measuring_unit: "g" }
rice_legumes = { name: "Rice and legumes", days_to_expiry: 365, measuring_unit: "g" }
charcuterie = { name: "Charcuterie", days_to_expiry: 180, measuring_unit: "g" }
fruit = { name: "Fruit", days_to_expiry: 10, measuring_unit: "u." }
vegetables = { name: "Vegetables", days_to_expiry: 20, measuring_unit: "u." }
dairy = { name: "Dairy", days_to_expiry: 30, measuring_unit: "g" }
liquids = { name: "Liquids", days_to_expiry: 30, measuring_unit: "ml" }
bakery = { name: "Bread and bakery", days_to_expiry: 15, measuring_unit: "g" }
sauces = { name: "Sauces", days_to_expiry: 365, measuring_unit: "ml" }
pasta = { name: "Pasta", days_to_expiry: 365, measuring_unit: "g" }

[fish_seafood, meat, rice_legumes, charcuterie, fruit, vegetables, dairy, liquids, bakery, sauces, pasta].each do |attributes|
  category = Category.create!(attributes)
  puts "Created #{category.name}"
end

puts "Creating ingredients..."

fish_seafood_names = [
  "Salmon",
  "Tuna",
  "Shrimp",
  "Trout",
  "Sardines",
  "Lobster",
  "Fish"
]

fish_seafood_names.each do |name|
  ingredient = Ingredient.create!(
    name: name,
    category: Category.find_by(name: "Fish and seafood")
  )
  puts "Created ingredient: #{ingredient.name}"
end

meat_names = [
  "Chicken breast",
  "minced beef",
  "Pork chops",
  "Lamb shoulder",
  "Bacon",
  "Turkey breast",
  "Beef tenderloin",
  "Sausages",
  "Ham",
  "Ground turkey"
]

meat_names.each do |name|
  ingredient = Ingredient.create!(
    name: name,
    category: Category.find_by(name: "Meat")
  )
  puts "Created ingredient: #{ingredient.name}"
end

rice_legumes_names = [
  "Rice",
  "Basmati rice",
  "Black beans",
  "Lentils",
  "Chickpeas",
  "Jasmine rice",
  "Green lentils",
  "Pinto beans",
  "Quinoa"
]

rice_legumes_names.each do |name|
  ingredient = Ingredient.create!(
    name: name,
    category: Category.find_by(name: "Rice and legumes")
  )
  puts "Created ingredient: #{ingredient.name}"
end

charcuterie_names = [
  "Ham",
  "Salami",
  "Chorizo",
  "Smoked bacon",
  "Pastrami",
  "Pepperoni",
  "Iberico"
]

charcuterie_names.each do |name|
  ingredient = Ingredient.create!(
    name: name,
    category: Category.find_by(name: "Charcuterie")
  )
  puts "Created ingredient: #{ingredient.name}"
end

fruit_names = [
  "Apple",
  "Banana",
  "Orange",
  "Strawberry",
  "Grapes",
  "Pineapple",
  "Blueberries",
  "Peach",
  "Pear",
  "Cherry"
]

fruit_names.each do |name|
  ingredient = Ingredient.create!(
    name: name,
    category: Category.find_by(name: "Fruit")
  )
  puts "Created ingredient: #{ingredient.name}"
end

vegetable_names = [
  "Carrot",
  "Broccoli",
  "Cauliflower",
  "Spinach",
  "Cucumber",
  "Tomato",
  "Lettuce",
  "Potato",
  "Onion",
  "Garlic",
  "Mushroom",
  "Green beans",
  "Peas",
  "Eggplant",
  "Cabbage",
  "Sweet potato",
  "Corn",
  "Asparagus"
]

vegetable_names.each do |name|
  ingredient = Ingredient.create!(
    name: name,
    category: Category.find_by(name: "Vegetables")
  )
  puts "Created ingredient: #{ingredient.name}"
end

dairy_names = [
  "Butter",
  "Cheese",
  "Yogurt",
  "Sour cream",
  "Cream cheese",
  "Greek yogurt"
]

dairy_names.each do |name|
  ingredient = Ingredient.create!(
    name: name,
    category: Category.find_by(name: "Dairy")
  )
  puts "Created ingredient: #{ingredient.name}"
end

liquid_names = [
  "Vegetable oil",
  "Olive oil",
  "Vinegar",
  "Honey",
  "Maple syrup",
  "Coconut milk",
  "Lemon juice"
]

liquid_names.each do |name|
  ingredient = Ingredient.create!(
    name: name,
    category: Category.find_by(name: "Liquids")
  )
  puts "Created ingredient: #{ingredient.name}"
end

sauce_names = [
  "Lemon juice",
  "Tomato sauce",
  "Barbecue sauce",
  "Soy sauce",
  "Teriyaki sauce",
  "Pesto sauce",
  "Sweet chili sauce",
  "Curry sauce"
]

sauce_names.each do |name|
  ingredient = Ingredient.create!(
    name: name,
    category: Category.find_by(name: "Sauces")
  )
  puts "Created ingredient: #{ingredient.name}"
end

bakery_names = [
  "Yeast",
  "Baking powder",
  "Baking soda",
  "Sandwick bread",
  "Bread"
]

bakery_names.each do |name|
  ingredient = Ingredient.create!(
    name: name,
    category: Category.find_by(name: "Bread and bakery")
  )
  puts "Created ingredient: #{ingredient.name}"
end

pasta_names = [
  "Spaghetti",
  "Fettuccine",
  "Farfalle",
  "Macaroni",
  "Couscous"
]

pasta_names.each do |name|
  ingredient = Ingredient.create!(
    name: name,
    category: Category.find_by(name: "Pasta")
  )
  puts "Created ingredient: #{ingredient.name}"
end

puts "Finished!"
puts "You have created #{Ingredient.count} ingredients."
