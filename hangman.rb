class Hangman

    def initialize
    @num_of_guesses = 7
    game
    end

    def pick_random_line
        lines = File.readlines('google-10000-english-no-swears.txt')
        lines[rand(lines.length)]
    end

    def game
        random_word = pick_random_line
        hidden_word = Array.new(random_word.length - 1, '_')

    end

end

game = Hangman.new