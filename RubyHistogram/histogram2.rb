bag = Hash.new(0)

$stdin.each do |line|
	line = line.chomp()
	words = line.gsub(/\s+/m, ' ').strip.split(" ") # strip, split line by spaces
	words.each do | word |
		parsed = word.downcase.gsub(/(\W|\d)/, "") # convert to lowercase and remove symbols
		if parsed.split.size > 0 # not an empty string
			bag[word.downcase.gsub(/(\W|\d)/, "")] += 1
		end
	end
end

bag.each do |key, value|
  if value > 1
  	puts "#{key}: #{value}"
  end
end
