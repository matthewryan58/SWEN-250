require 'pp'

bag = Hash.new(0)

$stdin.each do |line|
	line = line.chomp()
	words = line.gsub(/\s+/m, ' ').strip.split(" ") # split line by spaces
	words.each do | word |
		parsed = word.downcase.gsub(/(\W|\d)/, "") # convert to lowercase and strip symbols
		if parsed.split.size > 0 # non-empty string
			bag[word.downcase.gsub(/(\W|\d)/, "")] += 1
		end
	end
end

sorted = bag.sort_by {|k,v| v}.reverse # sort keys by descending values
longest = sorted[0][1] # first element contains highest value

# get min size from args, if exists
min_size = 2
if ARGV[0] != nil
	min_size = ARGV[0].to_i
end

# print
sorted.each do | apair |
  if apair[1] >= min_size
  	printf "%-*.*s ", longest, longest, apair[0]
  	puts "*" * apair[1]
  end
end
