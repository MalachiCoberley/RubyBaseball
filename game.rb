require_relative "team"
require_relative "inning"

class Game

  attr_reader :homeTeam, :awayTeam

  def initialize()
    @homeTeam = Team.new()
    @awayTeam = Team.new()
    @homeScore = 0
    @awayScore = 0
    @inning = 1
    @topOfInning = true
    @inningComplete = false
  end

  def playInningHalf(battingTeam, fieldingTeam)
    currentInning = Inning.new(battingTeam, fieldingTeam)

    until currentInning.complete
      currentInning.playInning
    end

    if battingTeam == @homeTeam
      @homeScore += currentInning.runs
    else
      @awayScore += currentInning.runs
    end
    p "That's the end of inning number #{@inning}"
    @inningComplete = true
  end

  def playBall()
    #Primary gameplay loop. Plays through a full 9 innings
    until @inning == 10
      #Determine which team is at bat
      until @inningComplete
        if @topOfInning
          self.playInningHalf(@awayTeam, @homeTeam)
        else
          self.playInningHalf(@homeTeam, @awayTeam)
        end
      end
      if @topOfInning
        @topOfInning = false
        @inningComplete = false
      else
        @topOfInning = true
        @inning += 1
        @inningComplete = false
      end
    end
  end


end

newGame = Game.new()
newGame.playBall()
