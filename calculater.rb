OPERATORS = %w(+ - * /)

def get_operator(str)
  operator = str.split.select do |v|
    OPERATORS.include?(v)
  end
  operator.shift.to_sym
end

def get_numbers(str, operator)
  str.scan(/\d/).map do |n|
    if operator == :/
      n.to_f
    else
      n.to_i
    end
  end
end

def calculate(numbers, operator)
  numbers.inject(operator)
end
  puts "Welcome! Please enter an expression. For example: 1 + 1"
loop do
  
  input = gets.chomp
  operator = get_operator(input)
  numbers = get_numbers(input,operator)
  result = calculate(numbers, operator)
  puts "The results for #{input} is: #{result}"
  puts "Would like to calculate anything else? (Y/N)"
  answer = gets.chomp
  break if answer.downcase == 'n'
  puts "=>"
end
