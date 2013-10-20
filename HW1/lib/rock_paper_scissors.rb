class RockPaperScissors
  # Exceptions this class can raise:
  class NoSuchStrategyError < StandardError ; end

  def self.winner(player1, player2)
    # Chequear parametros.
    raise RockPaperScissors::NoSuchStrategyError, "Strategy must be one of R,P,S" unless /[^RPS]/.match("#{player1[1]}#{player2[1]}") == nil
    
    #Separar las estrategias
    #Comparar estrategia.
    #Reglas> Rock breaks Scissors, Scissors cuts Paper, but Paper covers Rock.
    case player1[1]
    	when "R" 
    		 return player2 if player2[1] == "P"
    	when "S"
    		return player2 if player2[1] == "R"
    	when "P"
    		return player2 if player2[1] == "S"
    	else
    		return player1
    end
    return player1
  end

  def self.tournament_winner(array)
   if array[0][1].length == 1
    self.winner(array[0], array[1])
   else
    self.winner(self.tournament_winner(array[0]), self.tournament_winner(array[1]))
   end
  end

end

#[ ["Armando", "P"], ["Dave", "S"] ] # Dave would win since S > P
#p a = RockPaperScissors.winner(["Armando", "P"], ["Dave", "S"])
#p a = RockPaperScissors.winner(["Armando", "S"], ["Dave", "P"])
#p a = RockPaperScissors.winner(["Armando", "S"], ["Dave", "S"])

#Parametro w
#p a = RockPaperScissors.winner(["Armando", "P"], ["Dave", "w"])

#@rock = ['Armando','R'] ; @paper = ['Dave','P'] ; @scissors = ['Sam','S']
#p RockPaperScissors.winner(@rock, @scissors) == @rock
