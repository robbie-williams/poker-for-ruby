load 'game.rb'

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
    puts "go play with yourself..." if people == 1
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

game = RRP::Game.new people, draws
while !game.is_finished?
    game.next_state
end

game.get_player_hands
player = game.get_winner
winning_hand = RRP::PokerHand.new(player.cards)
puts "Winning player id: " + player.id.to_s + "(" + winning_hand.rank + ")"
