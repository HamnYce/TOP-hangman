# Frozen_string_literal: true

dictionary = File.new('5desk.txt', 'r')
hangman_dictionary = File.new('512desk.txt', 'w')
dictionary.each_line do |line|
  hangman_dictionary.puts line if line.length.between?(5,12)
end
dictionary.close
hangman_dictionary.close
