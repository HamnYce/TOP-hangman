# Frozen_string_literal: true

require 'json'

# Game class
class Game
  def initialize(word, lives_left = 10, correct_indeces = [],
                 wrong_letters = [])
    @lives_left = lives_left
    @correct_indeces = correct_indeces
    @word = word
    @wrong_letters = wrong_letters
    puts 'enter \'save\' at any point while guessing to save and exit the game'
    game_loop
  end

  def game_loop
    loop do
      break if @lives_left.zero?
      break if @correct_indeces.length == @word.length

      display_word_state
      puts 'enter a letter (or \'save\')'
      letter = take_user_guess

      save_game and break if letter == 'save'

      compare_letter_with_word(letter)
    end

    end_game_message
  end

  def save_game
    File.write('save_file/save.json', to_json)
  end

  def display_word_state
    word_state = '_' * @word.length
    @correct_indeces.each do |i|
      word_state[i] = @word[i]
    end
    puts "\n#{word_state} (wrong guesses: #{@wrong_letters.join(', ')})"
  end

  def compare_letter_with_word(letter)
    # test letter against word
    if (@correct_indeces.map { |i| @word[i]}).include? letter
      puts 'you\'ve already guessed that letter silly ;p'
    elsif @word.include? letter
      @word.downcase.split('').each_with_index do |chr, i|
        @correct_indeces.push(i) if chr == letter
      end
    else
      @wrong_letters.push letter
      @lives_left -= 1
      puts 'bing bong, that\'s wrong!'
    end
  end

  def take_user_guess
    user_guess = ''

    until (user_guess == 'save') || (user_guess.length == 1 &&
                                    user_guess =~ /[a-z]/i)
      puts 'enter guess'
      user_guess = gets.chomp
    end

    user_guess.downcase
  end

  def end_game_message
    if @correct_indeces.length == @word.length
      puts "\n#{@word} (wrong guesses: #{@wrong_letters.join(', ')})"
      puts 'Winner!'
    elsif @lives_left.zero?
      puts 'Oh No! You ran out of lives!'
    else
      puts 'Game Saved. Come back later!'
    end
    puts "Main Menu\nEnter:\nn - new game\nl - load game\ne - exit game\nh - to see this menu again"
  end

  def to_json(_optional = nil)
    "{
      \"word\":\"#{@word}\",
      \"lives_left\":#{@lives_left},
      \"correct_indeces\":#{@correct_indeces},
      \"wrong_letters\":#{@wrong_letters}
    }"
  end

  def self.from_json(json_file)
    save = JSON.parse(json_file.readlines.join)
    new(save['word'], save['lives_left'], save['correct_indeces'],
        save['wrong_letters'])
  end
end
