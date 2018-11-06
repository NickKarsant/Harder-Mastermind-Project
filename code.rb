require 'byebug'

class Code

  attr_reader :pegs

  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(array)
    array.all? { |el| POSSIBLE_PEGS.has_key?(el.upcase) }
  end

  def self.random(num)
    random_pegs = []
    num.times {random_pegs << POSSIBLE_PEGS.keys.sample}
    Code.new(random_pegs)
  end

  def self.from_string (string)
    arr = []
    string.each_char { |ch| arr << ch }
    Code.new(arr)
  end

  def initialize(array)
    if Code.valid_pegs?(array)
      @pegs = array.map(&:upcase)
    else
      raise 'Please enter valid pegs'
    end

  end

  def [](idx)
    @pegs[idx]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    matches = 0
    (0...guess.length).each { |i| matches += 1 if guess[i] == self[i] }
    matches
  end

  def remove_exact_matches(guess)
    no_exacts = []
    (0...guess.length).each do |i|
      if guess[i] != @pegs[i]
        no_exacts << guess[i]
      end
    end
    no_exacts
  end


  def num_near_matches(guess)
    matches = 0
    no_exacts = remove_exact_matches(guess)
    no_exacts.each_with_index do |el,i|
      matches += 1 if @pegs[i] != no_exacts[i] && no_exacts.include?(@pegs[i])
    end
    matches
  end


  def ==(arr)
    return true if num_exact_matches(arr) == arr.length
    false
  end


end

# code = ['g', 'r', 'y']
# guess = [ 'y', 'y', 'y']

# guess = ['y', 'y']


# guess.delete_at(idx)
# guess.delete_if { block }

# look at pegs
# identify exact matches
# remove exact matches from
# code to be run through num_near_matches = ['g', 'r']

# check num_near_matches = 0
