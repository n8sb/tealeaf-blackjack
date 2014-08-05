# Ruby Blackjack
# Work in progress. Things to add:
# Player betting
# Visualization of blackjack table
# Multiple decks
# Proper card names (King of Spades, Ace of Diamonds, etc)

# Calculate the total value of the current hands
def calculate_total(cards) 
# [['H', '3'], ['S', 'Q'], ... ]
  arr = cards.map {|i| i[1] }
  total = 0
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i 
    end
  end

  arr.count("A").times do
    total -= 10  if total > 21
  end

  total 
end

  puts "Welcome to Ruby Blackjack!"

  suits = ['H', 'D', 'S', 'C']
  cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

# Create cards
  deck = suits.product(cards)
  deck.shuffle!

  # Deal Cards

  mycards = []
  dealercards = []

  mycards << deck.pop
  dealercards << deck.pop
  mycards << deck.pop
  dealercards << deck.pop

  dealertotal = calculate_total(dealercards)
  mytotal = calculate_total(mycards)

  # Show Cards
  puts "You have: #{mycards[0]} and #{mycards[1]}, for a total of: #{mytotal}"
  puts "Dealer has: #{dealercards[1]} showing}"
  puts ""

  # Evaluate cards after initial deal
  # Player / dealer does not automatically win if they have blackjack. Could be a draw.
  if dealertotal == 21
    puts "Dealer has: #{dealercards[1]} and #{dealercards[0]}"
    puts "Dealer has blackjack. You lose."
    exit
  elsif mytotal == 21 && dealertotal != 21
    puts "Congrats, you got blackjack! You win!"
    exit
  elsif mytotal == 21 && dealertotal == 21
    puts "Dealer got blackjack too. It's a draw."
    exit
  end

# Loop through hitting
  while mytotal < 21
    puts "What would you like to do? 1) hit 2) stay"
    hit_or_stay = gets.chomp
# If correct option is not selected, player is asked again 
    if !['1', '2'].include?(hit_or_stay)
      puts ["Error: you must enter 1 or 2"]
      next
    end
# If stay is picked, will break out of while loop
    if hit_or_stay == "2"
      puts "You chose to stay."
      break
    end

# Dealing new card
    new_card = deck.pop
    puts "Dealing card to player: #{new_card}"
    mycards << new_card
    mytotal = calculate_total(mycards)
    puts "Your total is now: #{mytotal}"

# Evaluate after deal to player
    if mytotal == 21 && dealertotal == 21
      puts "Dealer got 21 too. It's a draw."
      exit
    elsif mytotal > 21
      puts "You busted!"
      exit
    end
  end  

  while dealertotal < 17
    new_card = deck.pop
    puts "Dealing new card for dealer: #{new_card}"
    dealercards << new_card
    dealertotal = calculate_total(dealercards)
    puts "Dealer total is now #{dealertotal}"

    if dealertotal == 21 && mytotal == 21
      puts "Dealer's cards: "
      dealercards.each do |card|
        puts "=> #{card}"
      end
      puts "Sorry, dealer has 21 too. It's a draw"
      exit
    elsif dealertotal == 21 && mytotal != 21
      puts "Dealer's cards: "
      dealercards.each do |card|
        puts "=> #{card}"
      end
      puts "Sorry, dealer has 21. You lose"
      exit
    elsif dealertotal > 21
      puts "Congrats! dealer busted! you win!"
      exit
    end
  end

  puts "Dealer's cards: "
  dealercards.each do |card|
    puts "=> #{card}"
  end

  puts "Your cards:"
  mycards.each do |card|
    puts "=> #{card}"
  end

  if dealertotal > mytotal
    puts "Sorry dealer wins: #{dealertotal} to #{mytotal}"
    exit
  elsif dealertotal < mytotal
    puts "Congrats, you win! #{mytotal} to #{dealertotal}"
    exit
  else
    puts "It's a tie. #{dealertotal} to #{mytotal}"
    exit
  end