require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = ('a'..'z').to_a
    10.times do
      x = alphabet.sample
      @letters << x
    end
    @letters
  end


  def score
    @response = params[:user_answer]
    @letters = params[:letters]

    url = "https://wagon-dictionary.herokuapp.com/#{@response}"
    serialized = open(url).read
    data = JSON.parse(serialized)

    @is_word = data["found"]
    @length = data["length"]
    @word = data["word"]

    @word_sorted = @word.split('').sort
    @letters_sorted = @letters.split.sort

    if @is_word == false
      @message = "Whoa cowboy, let's try using a valid word."
    elsif @letters_sorted.include?(@word_sorted)
      @message = "Nice"
    else
      @message = "Nope, wrong"
    end
  end

  @message
end
