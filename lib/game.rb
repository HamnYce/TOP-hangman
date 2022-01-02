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
      display_word_state
      puts 'enter a letter (or \'save\' to save and exit)'
      letter = take_user_guess
      if letter == 'save'
        File.write('save_file/save.json', to_json)
        break
      end
      compare_letter_with_word(letter)
    end
  end

  def display_word_state
    word_state = '_' * @word.length
    @correct_indeces.each do |i|
      word_state[i] = @word[i]
    end
    puts word_state
  end

  def compare_letter_with_word(letter)
    # test letter against word
    @word.each_with_index do |chr, i|
      @correct_indeces.push(i) if chr == letter
    end
  end

  def take_user_guess
    user_guess = ''
    user_guess = gets.chomp until (user_guess == 'save') ||
                                  (user_guess.length == 1 &&
                                  user_guess =~ /[a-z]/i &&
                                  !@word.include?(user_guess))
  end

  def to_json(_optional)
    "{\n
      \"word\":#{@word},\n
      \"lives_left\":#{@lives_left},\n
      \"correct_indeces\":#{@correct_indeces},\n
      \"wrong_letters\":#{@wrong_letters}\n
    }"
  end

  def self.from_json(json)
    save = JSON.parse(json)
    new(save[:word], save[:lives_left], save[:correct_indeces],
        save[:wrong_letters])
  end

  def savefile_name
    @savefile_name = "#{Dir.glob('save_files/*').max.split('.')[0].succ}.json"
  end

  def completed?
    @lives_left.zero? || @correct_indeces.length == @word.length
  end
end
