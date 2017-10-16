require './MovieManager.rb'
require 'test/unit'

class MovieManagerTest < Test::Unit::TestCase

  def test_000_smokeTest
    demoList = MovieList.new	# create local list just to do a basic test that we can instantiate MovieList
    assert_not_nil( demoList, 'Should be able to create a MovieList collection')
	demoMovie = Movie.new( 'a name', 1, 'test' )
	assert_not_nil( demoMovie, 'Should be able to create a movie' )
  end
  
  ################################################################################
  # First make sure you have all of the Movie class features implemented correctly
  ################################################################################

  # Create an instance of Movie with a name in all lower case and verify that the name is stored as upper case
  def test_001
    movie = Movie.new( 'casablanca', 10, 'Good' )
	assert( movie.name == 'CASABLANCA', 'Failed to convert movie name to upper case' )
  end
  
  # Create a movie with no rating and verify that the rating is 5
  def test_002
    movie = Movie.new( 'casablanca' )
	assert( movie.rating == 5, 'Failed to set rating to 5 when no rating is provided. Rating is: ' + movie.rating.to_s )
  end
  
  # Create a movie with a rating of 3 but no review. Verify that the default review is "No Review Entered" and the rating is 3
  def test_003
    movie = Movie.new( 'casablanca', 3 )
	assert( movie.rating == 3, 'Failed to set rating to 3 when rating is provided. Actual rating is: ' + movie.rating.to_s )
	assert( movie.review == 'No Review Entered', 'When no review is entered the default review string must be used' )
  end
  
  # Create a movie with a valid rating and a review of 'Good' and verify that the review is correct.
  def test_004
    movie = Movie.new( 'casablanca', 3, 'Good' )
	assert( movie.review == 'Good', 'Expected the review to be Good but got: ' + movie.review )
  end
  
  # Verify that a movie with a rating of 0 is set to 5
  def test_005
    movie = Movie.new( 'casablanca', 0 )
	assert( movie.rating == 5, 'Failed to change a rating of 0 to 5. Actual rating is: ' + movie.rating.to_s )
  end
  
  # Verify that a movie with a rating of 11 is set to 5
  def test_006
    movie = Movie.new( 'casablanca', 11 )
	assert( movie.rating == 5, 'Failed to change a rating of 11 to 5. Actual rating is: ' + movie.rating.to_s )
  end
  
  # 
  ##################################################################################
  # Now test the MovieList class. You may want to create a movie list using a setup.
  ##################################################################################

  # Verify that an empty MovieList has zero movies.
  def test_007
    testList = MovieList.new
    assert( testList.size == 0, 'An empty MovieList must have a count of zero' )
  end
  
  # Add a Movie to an empty MovieList and verify there there is now one movie in the list.
  def test_008
    testList = MovieList.new
    movie = Movie.new( 'casablanca', 3, 'Good' )
    testList.add( movie )
	assert( testList.size == 1, 'Number of movies must now be 1. Actual number is: ' + testList.size.to_s )
  end
  
  # With two different movies in a movie list verify that the size is 2
  def test_009
    testList = MovieList.new
    movie = Movie.new( 'Gone with the Wind', 6, 'Better' )
	testList.add( movie )
    movie = Movie.new( 'Grease', 9, 'best' )
    testList.add( movie )
	assert( testList.size == 2, 'Number of movies must be 2. Actual number is: ' + testList.size.to_s )
  end
  
  # With two movies in a movie list verify that the MovieList sortByName returns the correct list of movie names
  def test_010
    testList = MovieList.new
    movie = Movie.new( 'Gone with the Wind', 6, 'Better' )
	testList.add( movie )
    movie = Movie.new( 'Grease', 9, 'best' )
    testList.add( movie )
	expected = [ 'GONE WITH THE WIND', 'GREASE' ]
	actual = testList.sortByName
	assert( actual == expected, 'List of movies is incorrect. The returned list is: ' + actual.to_s )
  end
  
  # With two movies in a movie list verify that the MovieList sortByName returns the correct list of movie names
  def test_011
    testList = MovieList.new
    movie2 = Movie.new( 'Gone with the Wind', 6, 'Better' )
	testList.add( movie2 )
    movie1 = Movie.new( 'Grease', 9, 'best' )
    testList.add( movie1 )
	expected = [ movie1, movie2 ]
	actual = testList.sortByRating
	assert( actual == expected, 'List of movies is not sorted correctly by rating. First is: ' + actual[0].name )
  end
  
  # Verify that duplicate (case must not be considered) movies are ignored and that the original entry is retained.
  def test_012
    testList = MovieList.new
    movie2 = Movie.new( 'grease', 6, 'Better' )
	testList.add( movie2 )
    movie1 = Movie.new( 'Grease', 9, 'best' )
    testList.add( movie1 )
	assert( testList.size == 1, 'Incorrectly added a duplicate movie.' )
	rating = testList.sortByRating[0].rating
	assert( rating == 6, 'Failed to retain original movie rating. The stored rating is: ' + rating.to_s )
  end
  
   # With two movies in a movie list verify that each one can be retrieved
  def test_013
    testList = MovieList.new
    movie2 = Movie.new( 'Gone with the Wind', 6, 'Better' )
	testList.add( movie2 )
    movie1 = Movie.new( 'Grease', 9, 'best' )
    testList.add( movie1 )
	foundMovie = testList.getMovie( 'grease' )
	assert_not_nil( foundMovie, 'Failure finding the movie GREASE in the movie list' )
	assert( foundMovie.name == 'GREASE', 'Expected GREASE but wrong movie returned. Movie found: ' + foundMovie.name )
	
	foundMovie = testList.getMovie( 'gone with the wind' )
	assert_not_nil( foundMovie, 'Failure finding the movie GONE WITH THE WIND in the movie list' )
	assert( foundMovie.name == 'GONE WITH THE WIND', 'Expected GONE WITH THE WIND but wrong movie returned. Movie found: ' + foundMovie.name )
  end
  
end 
