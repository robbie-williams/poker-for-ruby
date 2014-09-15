module RRP
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
            @draws = 0
            @players = Array.new(num_of_players){|p| p = Player.new}
            @players.each do |p|
                p.cards = Array.new(5){|c| c = get_card }
            end
        end
        
        def get_player_hand player
                index  = 1
                player.cards.each do |c|
                    puts "found a nil" if c.nil?
                end
                hand = RRP::PokerHand.new player.cards
                puts 'Player #' + player.id.to_s + '( ' + hand.rank + '):'
                player.cards.each do |c| 
                    puts index.to_s + ") " + c.to_s
                    index = index + 1
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

        def draw player
            hand_changed = false
            while( !hand_changed )
                puts "Player " + player.id.to_s + ", please input cards to discard:"
                puts "(say all to discard hand or just press enter to pass)"
                discards = $stdin.gets
                if (discards.strip == "all")
                    player.cards.clear
                    hand_changed = true
                else
                    discards = discards.split(' ')
                    return if discards.length == 0
                    discards.each do |d|
                        player.cards.each do |c|
                            if c.to_s.eql? d.to_s.strip
                                player.cards.delete c
                                hand_changed = true
                                break
                            end
                        end
                    end
                end
                puts "Invalid cards selected, either select no cards or choose those from your hand" if !hand_changed
            end
            while player.cards.length < 5
                player.cards << @@deck.draw
            end
        end

        def get_card
            card = @@deck.draw
            if card.nil?
                raise 'Ran out of cards in the deck'
            end
            return card
        end

        def is_finished?
            @num_of_draws <=  @draws
        end

        def next_state
           puts "Performing draw " + (@draws + 1).to_s + " of " + @num_of_draws.to_s
           @players.each do |p|
               get_player_hand p
               draw p
           end
           @draws = @draws + 1
        end
    end
end
