require_relative 'food'
require_relative 'database'
require_relative 'logging'
require 'test/unit'

class TestBasicFood < Test::Unit::TestCase
  def test_basic_food
    food = BasicFood.new('Bread', 10)

    assert( food.calories == 10, 'Failure in BasicFood calorie accessor' )
    assert( food.name == 'Bread', 'Failure in BasicFood name accessor' )
  end

  def test_recipe
    recipe = Recipe.new('Water', ['Hydrogen', 'Hydrogen', 'Oxygen'])

    assert( recipe.name == 'Water', 'Failure in Recipe name accessor' )
    assert( recipe.foods[0] == 'Hydrogen', 'Failure in Recipe foods accessor' )
    assert( recipe.foods[2] == 'Oxygen', 'Failure in Recipe foods accessor' )
  end

  def test_db_save
    File.truncate('FoodDB.txt', 0)
    db1 = FoodDB.new
    db1.add_basic_food('Water', '0')
    db1.add_recipe('Cake', ['Water'])
    db1.save
    db2 = FoodDB.new
    assert(db2.basic_foods.keys.size == 1, 'Failure in FoodDB BasicFood saving')
    assert(db2.basic_foods['Water'].name == 'Water', 'Failure in FoodDB BasicFood data saving')
    assert(db2.recipes.keys.size == 1, 'Failure in FoodDB Recipe saving')
    assert(db2.recipes['Cake'].name == 'Cake', 'Failure in FoodDB Recipe data saving')
  end

  def test_log_save
    File.truncate('DietLog.txt', 0)
    log1 = Log.new
    log1.add_item('idk', '04/26/2017')
    log1.save
    log2 = Log.new
    assert( log2.log_items.size == 1, 'Failure in Log LogItem saving' )
    assert( log2.log_items[0].name == 'idk', 'Failure in Log LogItem data saving' )
  end
end
