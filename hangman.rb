class HangMan
	def initialize()
		words = ["boom", "dictionary", "slack", "ruby", "mined"]
		@hangman_word = words.sample
		@word_template = []
		@used_chars = []
	end

	def setupGame
		@failures = 10
		arrayTemplate(@hangman_word)
	end
	
	def arrayTemplate(string)
		@word_array = string.chars.map {|char| char}
		@word_array.each do
			@word_template.push("-")
		end
	end
	
	def checkChars?(guess) 
		if @used_chars.include?(guess)
			return false
		elsif @used_chars.include?(guess) == false
			@used_chars.push(guess)
			return true
		end
	end

	def guessInput(guess)
		if checkChars?(guess) == true
			if @word_array.include?(guess)
			@word_array.each_index do |ndx|
				if @word_array[ndx] != @word_template[ndx] && guess == @word_array[ndx]
					@word_template[ndx] = guess
				end
			end
		elsif
			 @word_array.include?(guess) == false
				@failures = (@failures - 1)
			end
		end
	end

	def playGame(guess)
		if @failures > 0 && @word_array != @word_template
		hangman_guess = guess
		guessInput(hangman_guess)
		end
	end

	def gameOver?
		if @failures <= 0 || @word_array == @word_template
			return true
		end
	end
	
	def set_new_session(session)
    	session[:hangman_word] = @hangman_word
    	session[:failures] = @failures
    	session[:word_template] = @word_template
    	session[:used_chars] = @used_chars
    	session[:word_array] = @word_array
  	end
	
	def set_current_session(session)
    	@hangman_word = session[:hangman_word]
    	@word_template = session[:word_template]
    	@used_chars = session[:used_chars]
    	@word_array = session[:word_array]
    	@failures = session[:failures]
  	end
end
