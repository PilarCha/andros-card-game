class Player
  attr_accessor :name,:dealer ,:hand, :total

  def initialize name, dealer = false, hand = [], total = 0
    @name = name
    @hand = hand
    @total = total
    @dealer = dealer
  end

  def show_hand
    puts
    print "#{@name} received "
    self.hand.each {|card| print "#{card.value} of #{card.suit} "}
    puts "totaling to #{self.total}"
  end

  def return_cards
    @hand = []
    @total = 0
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
    puts   player.show_hand
  end

end

class Setup

  def init_players
    @players = []
    i = 1
    while i <= 5 do
      player = Player.new("player#{i}")
      @players.push(player)
      i = i+1
    end
    @dealer = Player.new('Dealer',true)
    @players.push(@dealer)
    deal_cards
  end

  def deal_cards
    deck = Deck.new
    @players.each do |player|
      deck.deal(player)
    end
    find_winner
  end

  def find_winner
    winner = @dealer
    @players.each do |player|
      if(player.total > winner.total)
        winner = player
      end
    end
    if winner.dealer
      puts "#{winner.name} wins with a total of #{winner.total}. House wins. Players lose"
    else
      puts "#{winner.name} is the winner with a Total of #{winner.total}"
    end
    puts
    @players.each do |player|
      player.return_cards
    end
  end

end

puts "\e[H\e[2J"
puts "Welcome to Andros Card Game. Creating 5 players including dealer..."
puts "Object of game is to beat dealer with the highest sum of cards"

begin
  setup = Setup.new
  setup.init_players

  while true
    puts "Would you like to start a new game? y/n"
    input = gets.chomp
    if input.casecmp("Y") == 0
      setup.deal_cards
    else
      puts "Thank you for playing enjoy your day"
      break
    end
  end
rescue Exception => err
  $stderr.puts "#{err.class}: #{err.message}"
end
