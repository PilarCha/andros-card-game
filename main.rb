class Player
  attr_accessor :name, :hand, :bankroll, :total

  def initialize name, hand, bankroll, total
    @name = name
    @hand = hand
    @bankroll = bankroll
    @total = total
  end
end

class Card

  attr_accessor :face, :suit, :value

  def initialize face,suit,value
    @face = face
    @suit = suit
    @value = value
  end
end

class Deck
  def initialize
    # splat will expand the numbers 2-10
    @faces = [*(2..10), 'Jack','Queen','King','Ace']
    @suits = ['clubs','spades','hearts','diamonds']
    @cards = []

    @faces.each do |face|
      if face.class == Integer
        value = face
      elseif face == 'Ace'
        value = 11
      else
        value = 10
      end
      @suits.each do |suit|
        @cards << Card.new(face,suit,value)
      end
    end
  # !shuffle will replace original array
  @cards.shuffle!
  end
end
