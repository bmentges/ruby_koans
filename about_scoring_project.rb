require File.expand_path(File.dirname(__FILE__) + '/edgecase')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

class Greed
  def initialize(dices)
    @results = dices
  end

  def score
    return 0 if @results.empty?
    calculate_score
  end

  def calculate_score
    resultado = 0

    ones = @results.find_all { |n| n == 1 }
    twos = @results.find_all { |n| n == 2 }
    threes = @results.find_all { |n| n == 3 }
    fours = @results.find_all { |n| n == 4 }
    fives = @results.find_all { |n| n == 5 }
    sixes = @results.find_all { |n| n == 6 }

    all_sets = [ones, twos, threes, fours, fives, sixes]

    all_sets.each do |s|
      if s.count >= 3
        resultado += calculate_score_when_more_than_three s
      end

      if s[0] == 1 and s.count < 3
        resultado += s.count * 100
      end

      if s[0] == 5 and s.count < 3
        resultado += s.count * 50
      end
    end
    
   resultado 
  end

  def calculate_score_when_more_than_three numbers
    resultado = 0
    if numbers[0] == 1
      resultado += (numbers.count / 3) * 1000
      if numbers.count % 3 != 0
        resultado += (numbers.count % 3) * 100
      end
    end

    if [2,3,4,6].find { |n| n == numbers[0] } != nil
      resultado += (numbers.count / 3) * (numbers[0] * 100)
    end

    if numbers[0] == 5
      resultado += (numbers.count / 3) * 500
      if numbers.count % 3 != 0
        resultado += (numbers.count % 3) * 50
      end
    end

    resultado
  end


end

def score(dice)
  game = Greed.new(dice)
  game.score
  # You need to write this method
end

class AboutScoringProject < EdgeCase::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
  end

end
