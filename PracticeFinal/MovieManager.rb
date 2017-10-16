# Movie Manager 
# 
# Manages a collection of Movie objects. 
class MovieList
  def initialize
    @movies = Hash.new
    @numberOfMovies = 0    
  end
  
  def size
    @numberOfMovies
  end
  
  def add( movieToAdd )
    if getMovie(movieToAdd.name) == nil
      @movies.store( movieToAdd.name, movieToAdd)
      @numberOfMovies += 1
    end
  end
  
  def delete( movieToDelete )    
    @movies.delete(movieToDelete.upcase)
  end
  
  def getMovie(movieToFind)    
    @movies.fetch(movieToFind.upcase, nil) 
  end
  
  def sortByName	
    @names = []
    @movies.each do |key, value|
      @names.push(@movies[key].name)
    end 
    @names.sort     
  end
  
  def sortByRating
    @movies.values.sort_by { |x| -x.rating }
  end    
    
 end

# Movie Class - Models a movie entry - maintains movie title as an uppercase string,
#               rating (1-10) and text review.
class Movie
  attr_reader :rating
  attr_reader :review
  attr_accessor :name
      
  def initialize( aName, aRating=5, aReview="No Review Entered" )
    @name=aName.upcase! 
        self.rating=aRating
    @review=aReview
  end

  def rating=(value)
    if value <=10 && value >=1
      @rating = value
    else
      @rating = 5
    end
  end
end
