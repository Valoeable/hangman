class Hangman

    def initialize
    @num_of_guesses = 7
    @guessed_word = false
    @letters_available = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @guessed_letters = []
    game
    end

    attr_accessor :num_of_guesses, :guessed_word, :letters_available, :guessed_letters

    def pick_random_line
        lines = File.readlines('google-10000-english-no-swears.txt')
        lines[rand(lines.length)]
    end

    def game
        random_word = pick_random_line
        random_word = random_word.split('')
        random_word.pop
        hidden_word = Array.new(random_word.length, '_')
        game_over_display = %w[H A N G M A N]

        puts('Welcome to the game of Hangman!')

        until @num_of_guesses.zero? || @guessed_word
            puts('Select a letter which you think the word might contain:')
            chosen_letter = gets.chomp
            chosen_letter = chosen_letter.downcase

            was_it_a_hit(chosen_letter)

        end



        def was_it_a_hit(letter)

        end

    end

end

game = Hangman.new