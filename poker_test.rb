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
                p.cards = Array.new(5){|c| c = get_card }
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

        def get_card
            card = @@deck.draw
            if card.nil?
                raise 'Ran out of cards in the deck'
            end
            return card
        end
    end
end

def print_args_reminder
    puts "===Poker For Ruby==="    
    puts "Arguments:"    
    puts "1) Players - The number of players (Less than 5)"    
    puts "2) Draws - The number of draws in the game"
    puts ""
    puts "N.B: (Players * 5 * (Draws + 1)) < 52 condition must be satisfied"
    puts "==================="
end

#Get program arguments
invalid_args = false
if ARGV[0] == "-h"
    print_args_reminder
    exit
end

people = ARGV[0]
if people.nil?
    puts "No players argument given"
    invalid_args = true
else
    people = people.to_i
end

draws = ARGV[1]
if draws.nil?
 puts "No draw argument given"
else
    draws = draws.to_i
    if draws > 3 or draws < 0
        puts "Invalid number of draws"
        invalid_args = true
    end
end

if !invalid_args
    cards_to_be_used = (people * 5 * (draws + 1))
    if cards_to_be_used > 52
        puts "Too many cards will be used in this configuration (" + cards_to_be_used.to_s + " cards)."
        invalid_args = true
    end
end

if invalid_args
    print_args_reminder
    exit
end

game = Poker_Test::Game.new people, 2
game.get_player_hands



player = game.get_winner
winning_hand = RRP::PokerHand.new(player.cards)
puts "Winning player id: " + player.id.to_s + "(" + winning_hand.rank + ")"
