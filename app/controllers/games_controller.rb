require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ( 'A'..'Z').to_a.sample }
  end

  def score
    @answer = params[:word]
    user_letters = params[:word].split('')
    if user_letters.all? { |letter| user_letters.count(letter) <= params[:choices].split.count(letter) }
      response = open("https://wagon-dictionary.herokuapp.com/#{@answer}")
      json = JSON.parse(response.read)
      if json['found'] == false
        @results = "Sorry but #{params[:word]} is not an English word"
      else
        @results = "Congratulations #{params[:word]} is a valid English word"
      end
    else
      @impossible = "Sorry but #{params[:word]} can't be built out of #{params[:choices]}"
    end
  end
end
