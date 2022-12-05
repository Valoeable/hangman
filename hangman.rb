require 'yaml'

class Hangman

    def initialize
    @random_word = pick_random_line
    @hidden_word = Array.new(random_word.length - 1, '_')
    @times_lost = 0
    @guessed_word = false
    @letters_available = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @guessed_letters = []
    game
    end

    attr_accessor :guessed_word, :letters_available, :guessed_letters, :times_lost, :random_word, :hidden_word

    def pick_random_line
        lines = File.readlines('google-10000-english-no-swears.txt')
        lines[rand(lines.length)]
    end

    def game
        puts('Welcome to the game of Hangman!')
        puts('Would you like to start a fresh game or would you like to load the previous one?')
        puts('Type "new" for a new game or type "load" for an unsolved previous game.')

        game_start = gets.chomp

        game_loaded = 0

        if game_start == 'new'
            word_split(game_loaded)
            game_over_display = %w[H A N G M A N]
        elsif game_start == 'load'
            load_game
            game_loaded = 1
            word_split(game_loaded)
            game_over_display = %w[H A N G M A N]
            counter = 0
            until counter == @times_lost
                print game_over_display[counter]
                print(' ')
                counter += 1
            end
            print("\n")
        end
        
        saved_game = 0
        
        puts("Here lies the hidden word:#{hidden_word.join(' ')}")

        until @times_lost == 7 || @guessed_word
            puts("Your available letter are:#{@letters_available.join(' ')}")
            puts('Select a letter which you think the word might contain or write save if you want to rest up and solve the word later:')
            chosen_letter = gets.chomp
            chosen_letter = chosen_letter.downcase
            
            if @guessed_letters.include?(chosen_letter)
                puts('Sorry but you have to choose another letter, you already used this one.')
                next
            elsif chosen_letter == 'save'
                save_game
                saved_game = 1
                break
            else
                @guessed_letters.push(chosen_letter)
                i_of_guessed_letter = @letters_available.find_index(chosen_letter)
                @letters_available.delete_at(i_of_guessed_letter)
            end
            conclusion = was_it_a_hit(chosen_letter, random_word)

            if conclusion == 1
                @random_word.each_with_index do |letter, i|
                    if letter == chosen_letter
                        @hidden_word[i] = chosen_letter
                    end
                end
            else
                hangman_printout(game_over_display)
            end

            puts hidden_word.join(' ')

            @hidden_word == @random_word ? @guessed_word = true : @guessed_word = false

        end

        return if saved_game == 1

        @guessed_word == true ? puts('Damn bruv, you good at this!!!') : puts("Well, off to Hang myself!\nThe word was #{@random_word.join('')}.")

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

        def load_game
            yaml = YAML.load_file('/home/valoeable/anotherone/hangman/saved_game.yml', permitted_classes: [Hangman])
            @random_word = yaml[0].random_word
            @hidden_word = yaml[0].hidden_word
            @times_lost = yaml[0].times_lost
            @guessed_word = yaml[0].guessed_word
            @letters_available = yaml[0].letters_available
            @guessed_letters = yaml[0].guessed_letters
        end

        def save_game
            @random_word = @random_word.join('')
            File.open('saved_game.yml', 'w') { |f| YAML.dump([] << self, f) }
            puts 'Game successfully saved.'
        end

        def hangman_printout(game_over_display)
            if @times_lost.zero?
                puts game_over_display[@times_lost]
                @times_lost += 1
            else
                counter = 0
                until counter > @times_lost
                    print game_over_display[counter]
                    print(' ')
                    counter += 1
                end
                @times_lost += 1
                print("\n")
            end
        end

        def word_split(game_loaded)
            @random_word = @random_word.split('')
            if game_loaded == 1
                return
            else
                @random_word.pop
            end
        end

end



game = Hangman.new