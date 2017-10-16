require_relative 'food'

# Database for storing and accessing BasicFood and Recipe items
class FoodDB
  # Initialize hash tables with CSV data from file
  def initialize
    args = load_db
    @basic_foods = args[0] # hash table storing BasicFood objects
    @recipes = args[1] # hash table storing Recipe objects
  end
  # Parse CSV data from FoodDB.txt
  def load_db
    basic_foods = {} # store BasicFood objects
    recipes = {} # store Recipe objects
    File.readlines('FoodDB.txt').each do |line|
      line = line.chomp.split(",")
      if line[1] == "b"
        basic_food = BasicFood.new(line[0], line[2])
        basic_foods[basic_food.name] = basic_food
      elsif line[1] == "r"
        recipe = Recipe.new(line[0], line[2..line.size])
        recipes[recipe.name] = recipe
      end
    end
    [basic_foods, recipes]
  end
  attr_accessor :basic_foods, :recipes
  public
  # Create a BasicFood object and add to hash table
  def add_basic_food(name, calories)
    # Check if name already exists in hash tables
    if @basic_foods.has_key? name or @recipes.has_key? name
      puts "Food already exists in DB"
    else
      @basic_foods[name] = BasicFood.new(name, calories)
    end
  end
  # Create a Recipe object and add to hash table
  def add_recipe(name, foods)
    # Check if any items in foods don't exist in DB
    foods.each do |food|
      if not @basic_foods.has_key? food and not @recipes.has_key? food
        puts "Food doesn't exist in DB"
        return
      end
    end
    # Check if name already exists in hash tables
    if @basic_foods.has_key? name or @recipes.has_key? name
      puts "Food already exists in DB"
    else
      @recipes[name] = Recipe.new(name, foods)
    end
  end
  # Print Recipes and BasicFoods with names starting with prefix - case insensitive
  def find(prefix)
    # Iterate over BasicFoods for prefix
    @basic_foods.keys.each do |name|
      if name.downcase.start_with? prefix.downcase # convert both to downcase as case insensitive
        print(name)
      end
    end
    # Iterate over Recipes for prefix
    @recipes.keys.each do |name|
      if name.downcase.start_with? prefix.downcase # convert both to downcase as case insensitive
        print(name)
      end
    end
  end
  # Print all Recipes and BasicFoods in DB
  def print_all
    # Print all BasicFoods
    @basic_foods.each do |name, basic_food|
      print(name)
    end
    # Print all Recipes
    @recipes.each do |name, recipe|
      print(name)
    end
  end
  # Print Recipe or BasicFood matching name, recursively list foods if Recipe
  def print(name, level=0)
    # Check if food with name exists
    if not @basic_foods.has_key? name and not @recipes.has_key? name
      puts "Food not in DB"
      return
    end
    puts "  " * level + name + " " + count_calories(name).to_s
    # Check if food is a Recipe
    if @recipes.has_key? name
      # Print recipe's foods, increasing indentation level for them
      @recipes[name].foods.each do |food|
        print(food, level+1) 
      end
    end
  end
  # Return true if there is a BasicFood with name, false if not
  def is_basic_food(name)
    return @basic_foods.has_key? name
  end
  # Return true if there is a Recipe with name, false if not
  def is_recipe(name)
    return @recipes.has_key? name
  end
  # Count calories of food with name, recursively add calories of foods if Recipe
  def count_calories(name)
    if is_basic_food(name)
      return @basic_foods[name].calories # No recursion needed, BasicFood
    elsif is_recipe(name)
      calories = 0 # store calorie count of recipe
      # Recursively iterate over foods in Recipe, sum calories
      @recipes[name].foods.each do |food|
        calories += count_calories(food)
      end
      return calories
    end
  end
  # Save BasicFoods and Recipes in hash tables to FoodDB.txt in CSV format
  def save
    csv = [] # store CSV lines to write to file
    # Iterate over BasicFoods and retrieve CSV format for each 
    @basic_foods.each do |key, basic_food|
      csv.push(basic_food.csv)
    end
    # Iterate over Recipes and retrieve CSV format for each
    @recipes.each do |key, recipe|
      csv.push(recipe.csv)
    end
    File.write('FoodDB.txt', csv.join("\n")) # Write CSV lines to file
  end
end
