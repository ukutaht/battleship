# encoding: utf-8
require 'colored'
require 'pry'
require_relative 'constants'
require_relative 'indices'
require_relative 'cell'
require_relative 'coordinate_range'
require_relative 'ship'
require_relative 'board'
require_relative 'player'
require_relative 'computer_player'

class Battleship
    
    attr_accessor :player, :computer

    def initialize
      @player = Player.new
      @computer = ComputerPlayer.new
    end

    def show
      puts "\e[H\e[2J"
      play_board = PRINT_BOARD.dup
      @player.show_board.each do |cell|
        play_board.sub!('*', cell.content)
      end
      @computer.show_board.each do |cell|
        play_board.sub!('%', cell.content)
      end
      puts play_board
    end

    def show_ships_left
        puts "Ships left:"
        @player.fleet.each_with_index do |ship, index|
          puts "{#{index + 1}} #{ship.name}(length: #{ship.length})"
        end
    end

    def game_over?
      @player.all_ships_sunk || @computer.all_ships_sunk
    end
    

    def play
      until @player.ships_placed?
        show
        show_ships_left
        print "Choose a ship:"
        input_ship = gets.chomp
        ship = @player.fleet[input_ship.to_i - 1]
        if ship
          print "Choose the start and end index for your #{ship.name}(length: #{ship.length}):"
          input_indices = gets.chomp.split(',')
          coordinates = input_indices.size > 1 ? CoordinateRange.get(Indices.new(input_indices[0], input_indices[1])) : input_indices
          @player.place_ship(ship,coordinates)
        end
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
game = Battleship.new
game.play
