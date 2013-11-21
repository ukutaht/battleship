# encoding: utf-8
require 'colored'
require 'pry'
require_relative 'symbols'
require_relative 'indices'
require_relative 'cell'
require_relative 'coordinate_range'
require_relative 'board'
require_relative 'player'
require_relative 'constants'

class Battleship
    
    attr_accessor :player, :computer

    def initialize
      @player = Player.new
      @computer = ComputerPlayer.new
    end

    def show
      puts "\e[H\e[2J"
      play_board = PRINT_BOARD.dup
      @player.show_board.each do |letter|
        play_board.sub!('*', letter)
      end
      @computer.show_board.each do |letter|
        play_board.sub!('%', letter)
      end
      puts play_board
    end

    def show_ships_left
      unless @player.ships_placed?
        puts "Ships left:"
        puts "#{@player.fleet}"
      end
    end

    def game_over?
      !(@player.board.flatten.include?(SYMBOLS[:ship]) && @computer.board.flatten.include?(SYMBOLS[:ship]))
    end
    

    def play
      show
      until @player.ships_placed?
        show_ships_left
        print "Place your ships: "
        placement = gets.chomp.split(",")
        unless placement - Board.extract_all_indices
          puts "Invalid placement, stupid human"
          next
        end
        @player.place_ship!(placement[0], placement[1], placement[2])
      end
      show

      puts "LET'S PLAY!"
      sleep(1)

      @computer.place_all_ships
      until game_over?
        puts "Where do you want to fire?"
        at_index = gets.chomp
        unless Board.extract_all_indices.include?(at_index)
          puts "#{at_index} out of board, stupid human"
          next
        end
        if @computer.show_hits.include?(at_index)
          puts "You already hit #{at_index}, stupid human"
          next
        end
        binding.pry if at_index == "pry"
        @computer.board.fire!(at_index)
        show
        puts "Computer's turn"
        sleep(0.5)
        @player.board.fire!(@computer.fire_randomly)
        show

      end

      puts "Congrats, You win !!!"
      
    end


end
