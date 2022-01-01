# Frozen_string_literal: true

# Game class
class Game
  def initialize(lives = 10, correct_indeces = {}, wrong_letters = [])
    @lives = lives
    @correct_indeces = correct_indeces
    # each key value, should be index and letter
    @wrong_letters = wrong_letters
  end

  def game_loop
    puts 'game loop'
  end

  def to_json(optional); end

  def from_json(json_file)
    puts 'from json method in game class'
    File.
    new()
  end

  def savefile_name
    @savefile_name = "#{Dir.glob('save_files/*').max.split('.')[0].succ}.json"
  end
end
