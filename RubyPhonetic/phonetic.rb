# Convert to/from phonetic alphabet
# Jacob Wood

class Phonetic

  Letters = [
             ['A', 'ALPHA'],
             ['B', 'BRAVO'],
             ['C', 'CHARLIE'],
             ['D', 'DELTA'],
             ['E', 'ECHO'],
             ['F', 'FOXTROT'],
             ['G', 'GOLF'],
             ['H', 'HOTEL'],
             ['I', 'INDIA'],
             ['J', 'JULIET'],
             ['K', 'KILO'],
             ['L', 'LIMA'],
             ['M', 'MIKE'],
             ['N', 'NOVEMBER'],
             ['O', 'OSCAR'],
             ['P', 'PAPA'],
             ['Q', 'QUEBEC'],
             ['R', 'ROMEO'],
             ['S', 'SIERRA'],
             ['T', 'TANGO'],
             ['U', 'UNIFORM'],
             ['V', 'VICTOR'],
             ['W', 'WHISKEY'],
             ['X', 'XRAY'],
             ['Y', 'YANKEE'],
             ['Z', 'ZULU'],
             ]

  # Translate a word to its phonetic alphabet equivalent
  def self.to_phonetic(word)
    phonetic = [] # store phonetic equivalent
    word.chomp.split("").each do |c| # remove newline, iterate over each char
      phonetic.push(Letters[c[0].upcase.ord - "A".ord][1]) # use letter ascii value to find index in Letters
    end
    phonetic.join(" ") # convert array to string, phonetics seperated by spaces
  end

  # Translate a sequence of phonetic alphabet code words 
  # to their alphabetic equivalent
  def self.from_phonetic(str)
    alphabet = "" # store alphabetic equivalent
    str.chomp.split(" ").each do |phonetic| # remove trailing newline, split phonetics up
      alphabet += Letters[phonetic[0].upcase.ord - "A".ord][0] # take first letter of phonetic, use ascii value to find index in Letters
    end
    alphabet
  end

  # If the line starts with A2P, call to_phonetic on the rest of the substring
  # If the line starts with P2A, call from_phonetic on the rest of the substring
  # Otherwise, return nothing.
  def self.translate(line)
    # line[4..line.size] is sent to either method as it is all text after "CMD "
    if line.start_with? "A2P"
      to_phonetic(line[4..line.size]) 
    elsif line.start_with? "P2A"
      from_phonetic(line[4..line.size])
    end
  end
end

# This is ruby idiom that allows us to use both unit testing and command line processing
# This gets run with ruby phonetic.rb
# Does not get run when we use unit testing, e.g. ruby phonetic_test.rb
if __FILE__ == $PROGRAM_NAME
  $stdin.each do |line|
    puts Phonetic.translate(line)
  end
end
