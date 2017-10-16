require_relative 'MovieManager.rb'

# Write code that will read in a CSV list of movie ratings (one rating per line)
# that also can contain two different listing commands: LIST and RATINGS
# If the line is exactly LIST display a sorted list of movie names
# If the line is exactly RATINGS display all of the movies (name, rating, and review)
# in a list that is reverse sorted by rating (highest rated entries are listed first).

movielist = MovieList.new

$stdin.each do |line|
  line.chomp!
  if line == "LIST"
    puts movielist.sortByName
  elsif line == "RATINGS"
    puts movielist.sortByRating
  else
    csv = line.split(",")
    movielist.add((csv[0], csv[1], csv2))    
  end  
end
