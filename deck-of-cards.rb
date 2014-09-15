load 'card.rb'
module RRP
class DeckOfCards
  attr_reader :cards
  
  SUITS = ['h', 's', 'd', 'c']
  RANKS = ['2','3','4','5','6','7','8','9','T', 'J', 'Q', 'K', 'A']
  
  def initialize
    @cards = []
    SUITS.product(RANKS) { |suit, rank| @cards << RRP::Card.new(rank, suit) }
  end
  
  def to_s
    "#{@cards.count}-card deck."
  end

  def shuffle
    @cards.shuffle!
  end
  
  def cut
    @cards.rotate! @cards.count / 2
  end
  
  alias split cut
  
  def draw
    @cards.shift
  end
end
end
