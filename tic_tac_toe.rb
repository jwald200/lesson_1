WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
PLACEHOLDER = '-' #to use for empty squares

# helper methods
def initalize_squares
  b = {}
  (1..9).each { |square| b[square] = PLACEHOLDER }
  b
end

def free_squares(s)
  s.select { |_, v| v == PLACEHOLDER }.keys
end

def defend_line(s)
  WINNING_LINES.each do |line|
    currend_line = s.values_at(*line)
    if (currend_line.count('x') == 2) && (currend_line.count(PLACEHOLDER) == 1)
      return line
    end
  end
  false
end

def smart_pick(s, line)
  line.each { |k| s[k] = 'o' if s[k] == '-' }
end

def winner(s)
  player = s.select { |_, v| v == 'x' }.keys
  computer = s.select { |_, v| v == 'o' }.keys
  
  WINNING_LINES.each do |line|
    return 'player' if  (line & player).size == 3
    return 'computer' if (line & computer).size == 3
  end
  nil
end
# game methods

def draw_board(s)
  system 'clear'
  puts " #{s[1]} | #{s[2]} | #{s[3]}"
  puts " #{s[4]} | #{s[5]} | #{s[6]}"
  puts " #{s[7]} | #{s[8]} | #{s[9]}"
end

def player_picks_square(s)
  puts "Pick one of the avalible squares #{free_squares(s)}"
  begin
    pick = gets.chomp.to_i
    unless free_squares(s).include?(pick)
      puts "Have you chosen a square from the list? try again"
    end
  end until free_squares(s).include?(pick)
  s[pick] = 'x'
end

def game_over?(s)
  free_squares(s).empty? || winner(s)
end

def computer_picks_square(s)
  if defend_line(s)
    smart_pick(s, defend_line(s))
  else
    pick = free_squares(s).sample
    s[pick] = 'o'
  end
end

def display_results(s)
  if winner(s)
    puts "#{winner(s)} won!"
  else
    puts "It's a tie"
  end
end

# game begins
loop do
  squares = initalize_squares
  draw_board(squares)
  begin
    player_picks_square(squares)
    draw_board(squares)
    break if game_over?(squares)
    computer_picks_square(squares)
    draw_board(squares)
  end until game_over?(squares)
  display_results(squares)

  puts 'Play again? (Y/N)'
  break if gets.chomp == 'n'.downcase
end

puts 'Thanks for playing.'

