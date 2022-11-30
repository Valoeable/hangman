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
        times_lost = 0
        hidden_word = Array.new(random_word.length, '_')
        game_over_display = %w[H A N G M A N]

        puts('Welcome to the game of Hangman!')

        until @num_of_guesses.zero? || @guessed_word
            puts("Your available letter are:#{@letters_available.join(" ")}")
            puts('Select a letter which you think the word might contain:')
            chosen_letter = gets.chomp
            chosen_letter = chosen_letter.downcase
            
            if @guessed_letters.include?(chosen_letter)
                puts('Sorry but you have to choose another letter, you already used this one.')
                next
            else
                @guessed_letters.push(chosen_letter)
                i_of_guessed_letter = @letters_available.find_index(chosen_letter)
                @letters_available.delete_at(i_of_guessed_letter)
            end
            conclusion = was_it_a_hit(chosen_letter, random_word)

            if conclusion == 1
                random_word.each_with_index do |letter, i|
                    if letter == chosen_letter
                        hidden_word[i] = chosen_letter
                    end
                end
            else
                if times_lost == 0
                    puts game_over_display[times_lost]
                    times_lost += 1
                else
                    counter = 0
                    until counter > times_lost
                        print game_over_display[counter]
                        print(' ')
                        counter += 1
                    end
                    print("\n")
                end
            end

            puts hidden_word.join(' ')

            hidden_word == random_word ? @guessed_word = true : @guessed_word = false

        end

        @guessed_word == true ? puts('Damn bruv, you good at this!!!') : puts('"Well, off to Hang myself!"')

    end



        def was_it_a_hit(letter, generated_word)

            if generated_word.include?(letter)
                puts('Cool, you got the correct letter, keep it up!')
                return 1
            else
                puts("Unluuucky, don't worry though, it's not over yet.")
                return 0
            end

        end

end



game = Hangman.new