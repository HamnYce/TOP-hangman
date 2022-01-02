# Frozen_string_literal: true
require_relative 'game'

def new_game
  word = random_word
  # p word
  Game.new(word)
end

def random_word
  words = File.new('512desk.txt', 'r').readlines
  words[rand(words.length)].chomp
end

def load_game
  if File.exist? 'save_file/save.json'
    Game.from_json(File.new('save_file/save.json'))
  else
    puts 'There is no save file present, try out a new game first ^^!'
  end
end

choice = ''
menu = "Main Menu\nEnter:\nn - new game\nl - load game\ne - exit game\nh - to see this menu again"

puts "\n       Hangman\nYou have to guess the word within 10 lives\n"
puts menu

until choice == 'e'
  choice = gets.chomp

  case choice
  when 'n'
    new_game
  when 'l'
    load_game
  when 'h'
    puts menu
  when 'e'
    puts 'Thank you for playing :)'
  else
    puts 'Please enter a valid input. Thanks!'
  end
end
