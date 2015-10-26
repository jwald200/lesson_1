CHOICES = { 'r' => 'Rock', 'p' => 'Paper', 's' => 'Scissors' }
WINNING_SCENARIOS = { 'r' => ['r', 's'], 'p' => ['p', 'r'], 's' => ['p', 's'] }
player = { 'wins' => 0 }
computer = { 'wins' => 0 }

def winner?(game)
  WINNING_SCENARIOS.values.include?(game.sort!)
end

def winner_name(player, computer, game)
  if player['pick'] == WINNING_SCENARIOS.key(game)
    player['wins'] += 1
    'Player'
  else
    computer['wins'] += 1
    'Computer'
  end
end

puts 'welcome! to Rock, Paper, Scissors game'
puts 'How many times whould you like to play?'
rounds = gets.chomp.to_i
games_played = 0

rounds.times do
  begin
    puts 'Please choose [r] for Rock, [p] for Paper, or [s] for Scissors.'
    input = gets.chomp.downcase
  end until CHOICES.keys.include?(input)
  
  player['pick'] = input
  computer['pick'] = CHOICES.keys.sample
  game = [player['pick'], computer['pick']]

  puts "Player's hand: #{CHOICES[player['pick']]}"
  puts "Computer's hand: #{CHOICES[computer['pick']]}"
  if winner?(game)
    puts "#{winner_name(player, computer, game)} won!"
  else
    puts "It's a tie"
  end
  puts "Player's wins: #{player['wins']} computer's wins: #{computer['wins']}"
  
  games_played += 1
end

puts "Nice job! You've played #{games_played} games."
