# Script that obtains various git metrics from a basic git log file
require 'set'
require 'date'

# Given an array of git log lines, count the number of commits in the log
def num_commits(lines)
  # iterate through lines, count those that start with "commit"
  count = 0
  lines.each do | line |
    if line.start_with?("commit")
      count += 1
    end
  end
  count
end

# Given an array of git log lines, count the number of different authors
#   (Don't double-count!)
# You may assume that emails make a developer unique, that is, if a developer
# has two different emails they are counted as two different people.
def num_developers(lines)
  # extract emails, use as keys in hash objects to remove duplicates
  devs = Hash.new
  lines.each do | line |
    if line.start_with?("Author:")
      email = line.split("<")[1].split(">")[0]
#      if email.include?("+")
#        email = email.split("+")[0] + "@" + email.split("@")[1]
#      else
#        email = email.split("@")[0] + "@" + email.split("@")[1].downcase
#      end
      devs[email] = 1
    end
  end
  devs.keys.size # number of keys is number of unique devs
end

# Given an array of Git log lines, compute the number of days this was in development
# Note: you cannot assume any order of commits (e.g. you cannot assume that the newest commit is first).
def days_of_development(lines)  
  newest = nil # newest date in log
  oldest = nil # oldest date in log

  lines.each do | line |
    if line.start_with?("Date:")
      parsed = DateTime.parse(line.split("Date:")[1].lstrip) # extract date from line
      if newest == nil and oldest == nil
        # neither date set, set both
        newest = parsed
        oldest = parsed
      else
        if parsed > newest
          newest = parsed
        elsif parsed < oldest
          oldest = parsed
        end
      end
    end
  end
  if newest == nil or oldest == nil
    0 # no dates set
  else
    (newest - oldest).to_i + 1 # add one to match provided outputs...
  end
end

# This is a ruby idiom that allows us to use both unit testing and command line processing
# Does not get run when we use unit testing, e.g. ruby test_git_metrics.rb
# These commands will invoke this code with our test data: 
#    ruby git_metrics.rb < ruby-progressbar-short.txt
#    ruby git_metrics.rb < ruby-progressbar-full.txt
if __FILE__ == $PROGRAM_NAME
  lines = []
  $stdin.each { |line| lines << line }
  puts "Nunber of commits: #{num_commits lines}"
  puts "Number of developers: #{num_developers lines}"
  puts "Number of days in development: #{days_of_development lines}"
end

