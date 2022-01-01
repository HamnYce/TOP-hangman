# Frozen_string_literal: true
# words between 5 and 12 letters
# display ascii sprites (Optional)
# display guessed/unguessed letters (underscores)
# case insensitive
# implement save function during the game at any point
#   save: lives_left, word_to_be_guessed, guessed_letters(indicis),
#         user_name(for save file name)
# implement a load function at the main menu

# Screens
# Main Menu -> New Game -> random_word_chosen, game_object_inits_normally
#           -> Load Game -> pick_save_file_from_list,
#                           game_object_creation_from_json (game continues
#                           normally)
#           -> Exit Game -> output_thank_you_message, kill_program
require_relative 'game'

choice = ''
menu = "Main Menu\nEnter:\nn - new game\nl - load game\ne - exit game\nh - to see this menu again"
puts menu

until choice == 'e'
  choice = gets.chomp
  case choice
  when 'n'
    Game.new
  when 'l'
    if File.exist? 'save_file/save.json'
      File.open('save_file/save.json') { |file| Game.from_json(file) }
      File.delete('save_file/save.json')
    else
      puts 'There is no save file present, try out the new game option instead ^^!'
    end
  when 'h'
    puts menu
  else
    puts 'please enter a valid input. Thanks!'
  end
end