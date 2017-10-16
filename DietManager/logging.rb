require 'date'

# Store log entries, perform operations on them
class Log
  def initialize
    @log_items = load_log # store array of LogItems
  end
  # Parse CSV LogItems from DietLog.txt
  def load_log
    log_items = []
    File.readlines('DietLog.txt').each do |line|
      line = line.chomp.split(",")
      log_items.push(LogItem.new(line[0], line[1]))
    end
    log_items
  end
  attr_accessor :log_items
  public
  # Print all LogItems
  def show_all
    # Iterate over all LogItems
    date = nil
    @log_items.each do |log_item|
      if log_item.date != date
        date = log_item.date
        puts date
      end
      puts "  " + log_item.name
    end
  end
  # Print each LogItem with date
  def show(date)
    # Iterate over LogItems, compare date
    @log_items.each do |log_item|
      if log_item.date == date
        puts log_item.name
      end
    end
  end
  # Create LogItem with name,date and add to log_items
  def add_item(name, date)
    parsed_date = Date.strptime(date, '%m/%d/%Y') # Parse date to Date object for comparison
    # Iterate over LogItems, find insertion location based on date (ascending order)
    @log_items.each do |log_item|
      if parsed_date < Date.strptime(log_item.date, '%m/%d/%Y')
        @log_items.insert(@log_items.index(log_item), LogItem.new(date, name))
        return
      end
    end
    # LogItem wasn't inserted (either greatest date or empty log_items), insert now
    @log_items.push(LogItem.new(date, name))
  end
  # Delete LogItem with name and date
  def delete_item(name, date)
    @log_items.delete_if do |log_item|
      # Use delete_if method's comparison to capture matching log entry
      if log_item.name == name and log_item.date == date
        true
      end
    end
  end
  # Save log_items in CSV format to DietLog.txt
  def save
    csv = [] # CSV lines to write to file
    # Retrieve CSV line for each LogItem
    @log_items.each do |log_item|
      csv.push(log_item.csv)
    end
    File.write('DietLog.txt', csv.join("\n"))
  end
end

# Store log entries
class LogItem
  def initialize(date, name)
    @date = date # store date of entry
    @name = name # store name of food in entry
  end
  attr_accessor :date, :name
  public
  # return CSV format of LogItem
  def csv
    @date + "," + @name
  end
end

# Get current date in format used for logs
def time_now
  DateTime.now.strftime('%m/%d/%Y')
end
