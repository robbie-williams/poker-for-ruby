module Poker_Test
load 'card.rb'
load 'poker_hand.rb'
load 'deck-of-cards.rb'
    class Player
        attr_accessor :id, :cards
        @@player_count = 0
        def initialize
            @@player_count = @@player_count + 1
            @id = @@player_count
        end
    end

    class Game
            @@deck = RRP::DeckOfCards.new
        
        def initialize num_of_players, num_of_draws
            @@deck.shuffle
            @num_of_draws = num_of_draws
            @players = Array.new(num_of_players){|p| p = Player.new}
            @players.each do |p|
                p.cards = Array.new(5){|c| c = @@deck.draw}
            end
        end


        def get_player_hands
            @players.each do |p|
                index  = 1
                p.cards.each do |c|
                    puts "found a nil" if c.nil?
                end
                hand = RRP::PokerHand.new p.cards
                puts 'Player #' + p.id.to_s + '( ' + hand.rank + '):'
                p.cards.each do |c| 
                    puts index.to_s + ") " + c.to_s
                    index = index + 1
                end
            end
          RRP::Card.new  
        end

        def get_winner
            winner = @players.first
            winning_hand = RRP::PokerHand.new @players.first.cards
            @players.each do |p|
                next if winner.id == p.id
                hand = RRP::PokerHand.new p.cards
                if hand > winning_hand then
                    winner = p
                    winning_hand = hand
                end
            end
            return winner
        end

    end
end

people = ARGV[0].to_i
people = 2 if people == nil
game = Poker_Test::Game.new people, 2
game.get_player_hands
player = game.get_winner
puts "Winning player id: " + player.id.to_s
