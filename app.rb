require 'sinatra'
require_relative 'hangman.rb'

configure do
  enable :sessions
  set :session_secret, "secret"
end
helpers do
	def cleanup
		@format_used_chars = session[:used_chars].join
		@format_word = session[:word_template].join
	end
end

get '/' do
	erb :hangman
end


get '/startgame' do
	game = HangMan.new
	session[:game] = game
	game.setupGame
	@session = session
	session = game.set_new_session(@session)
	redirect '/results'
end

get '/results' do
	game = HangMan.new
	@session = session
	session = game.set_current_session(@session)
	if game.gameOver?
		redirect '/gameover'
	else
	cleanup
	erb :results
	end
end

get '/guess' do
	game = HangMan.new
	@session = session
	@hmguess = params[:hmguess]
	game.set_current_session(@session)
	game.playGame(@hmguess)
	session = game.set_new_session(@session)
	cleanup
	erb :results
	redirect '/results'
end

get '/gameover' do
erb :gameover
end