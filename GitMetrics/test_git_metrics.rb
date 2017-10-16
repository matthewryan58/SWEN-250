require_relative 'git_metrics'
require 'test/unit'

class TestGitMetrics < Test::Unit::TestCase

  def test_commit_example
  	assert_equal 2, num_commits(["commit abc", "commit 123"]), "Should have counted two commits"
  end

  def test_dates_with_three_days
  	exp = [ "Date:  Sun Jan 26 21:25:22 2014 -0600", \
  			"Date:  Sun Jan 23 21:25:22 2014 -0600", \
  			"Date:  Sun Jan 25 21:25:22 2014 -0600"]
    assert_equal 4, days_of_development(exp), "Should have been a 4 days difference"
  end

  def test_devs_with_three_devs
	exp = [ "Author: Barrack Obama <obama@whitehouse.gov>", \
		"Author: Jordan Bellfort <jordan@straton.com>", \
		"Author: Sean Spicer <spicy@whitehouse.gov>" ]
	assert_equal 3, num_developers(exp), "Should have 3 different developers"
  end

  def test_devs_with_two_devs
  	exp = [ "Author: Elon Musk <elon@tesla.com>", \
		"Author: Elon Musk <elon@tesla.com", \
		"Author: Bobby Bob <bob@bob.com>" ]
	assert_equal 2, num_developers(exp), "Should have 2 different developers"
  end

  def test_commit_with_no_commits
	exp = [ "Author: Test Test <test@test.com>", \
		"Author: What Ever <whatever@gmail.com>", \
		"Date: Sun Jan 23 00:00:00 2014 -0600"]
	assert_equal 0, num_commits(exp), "Should have 0 developers"
  end
  
  def test_dates_with_no_dates
	exp = [ "Author: Ever What <whatever@what.com>", \
		"commit 3asdfasdf" ]
	assert_equal 0, days_of_development(exp), "Should have 0 development days"
  end

  def test_devs_with_no_devs
	exp = [ "commit asdf" \
		"Date: Sun Jan 23 00:00:00 2014 -0600" ]
	assert_equal 0, num_developers(exp), "Should have 0 developers"
  end

end
