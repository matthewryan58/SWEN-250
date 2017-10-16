require_relative 'database'
require_relative 'logging'

# create log and DB files if they don't exist
if not File.file?("DietLog.txt")
  File.open("DietLog.txt", "w") {}  
end
if not File.file?("FoodDB.txt")
  File.open("FoodDB.txt", "w") {}
end

# load data
db = FoodDB.new
log = Log.new

# read commands
modified = false
$stdin.each do |line|
  if line.start_with? "quit" # quit
    if modified # only save if modified
      db.save
      log.save
    end
    modified = false
    break # stop reading input
  elsif line.start_with? "save" # save
    if modified # only save if modified
      db.save
      log.save
    end
    modified = false # db saved, reset modified state
  elsif line.start_with? "print" # print all; print <name>
    arg = line.chomp.split(" ")[1]
    if arg == "all"
      db.print_all
    else
      db.print(line.chomp.split("print ")[1])
    end
  elsif line.start_with? "new" # new recipe, new food
    modified = true # adding an element modifies the db
    type = line.chomp.split(" ")[1]
    args = line.chomp.split("new " + type + " ")[1].split(",")
    if type == "food"
      db.add_basic_food(args[0], args[1])
    elsif type == "recipe"
      db.add_recipe(args[0], args[1..args.size])
    end
  elsif line.start_with? "find" # find <name>
    arg = line.chomp.split("find ")[1]
    db.find(arg)
  elsif line.start_with? "log" # log <name>; log <name>,<date>
    modified = true
    arg = line.chomp.split("log ")[1].split(",")
    if not db.basic_foods.has_key? arg[0] and not db.recipes.has_key? arg[0]
      puts "Food not in DB"
    else
      if arg.size == 1
        log.add_item(arg[0], time_now)
      else
        log.add_item(arg[0], arg[1])
      end
    end
  elsif line.start_with? "delete" # delete <name>,<date>
    modified = true
    args = line.chomp.split("delete ")[1].split(",")
    log.delete_item(args[0], args[1])
  elsif line.start_with? "show" # show; show all; show <name>
    if line.chomp.split(" ").size > 1
      arg = line.chomp.split("show ")[1]
      if arg == "all"
        log.show_all
      else
        log.show(arg)
      end
    else
      log.show(time_now)
    end
  end
end

# will only be reached if EOF encountered
if modified
  db.save
  log.save
end
