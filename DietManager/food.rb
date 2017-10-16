# Used to store basic food data
class BasicFood
  def initialize(name, calories)
    @name = name # store name of food
    @calories = calories.to_i # store calorie count of food
  end
  attr_accessor :name, :calories
  public
  # returns CSV format of object, used to store to txt DB
  def csv
    @name + ",b," + @calories.to_s
  end
end

# Used to store recipe data
class Recipe
  def initialize(name, foods)
    @name = name # store name of food
    @foods = foods # store array of food names in recipe
  end
  attr_accessor :name, :foods
  public
  # returns CSV format of object, used to store to txt DB
  def csv
    @name + ",r," + @foods.join(",")
  end
end
