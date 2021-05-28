class Player
  attr_accessor :name, :hand, :total

  def initialize name, hand = [], total = 0
    @name = name
    @hand = hand
    @total = total
  end

  def show_hand
    self.hand.each {|card| puts "#{self.name} has a card value of #{card.value}"}
    puts "#{self.name} Totaling an amount of #{self.total}"
  end
end

class Card

  attr_accessor :face, :suit, :value

  def initialize face,suit,value
    @face = face
    @suit = suit
    @value = value
  end

  def generate_card (player)
    new_card = Card.new face, suit, value
    player.hand << new_card
    player.total = player.total + new_card.value
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
      elsif face == 'Ace'
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

  def deal (player)
    2.times{@cards.shift.generate_card(player)}
  end

end

class Setup

  def init_players
    deck = Deck.new
    i = 1
    while i < 5 do
      puts i
      p = Player.new("player#{i}")
      deck.deal(p)
      i = i+1
    end


  end
end

puts "\e[H\e[2J"
puts "Welcome to Andros Card Game. Starting up..."
puts "Creating 5 players including dealer..."
puts "Object of game is to beat dealer with the highest sum of cards"

begin
  setup = Setup.new
  setup.init_players
end




# player1 = Player.new "Juan"
# player2 = Player.new "Bob"
# player3 = Player.new "Steve"
# player4 = Player.new "Joe"
# player5 = Player.new "Johnny"
# dealer = Player.new "Dealer"

# deck = Deck.new
# deck.deal(player1)
# deck.deal(player2)
# deck.deal(player3)
# deck.deal(player4)
# deck.deal(player5)
# deck.deal(dealer)

# puts "\e[H\e[2J"
# player1.show_hand
