class Player

  @health = nil
  MINIMUM = 8
  MAXIMUM = 20
  @saved = nil


  def play_turn(warrior)

    @health = warrior.health unless @health != nil
    @saved = false unless @saved != nil

    if warrior.feel.wall?
      warrior.pivot! :backward
      @saved = true

    #BACKWARD:
    elsif warrior.feel(:backward).empty? && @saved == false
      warrior.walk! :backward

    elsif warrior.feel(:backward).captive?
      warrior.rescue! :backward
      @saved = true
        
    #FORWARD
    elsif warrior.feel.empty?

      if warrior.health < @health && warrior.health <= MINIMUM
        warrior.walk! :backward
      elsif warrior.health < @health && warrior.health > MINIMUM
        warrior.walk!
      elsif warrior.health >= @health && warrior.health < MAXIMUM
        warrior.rest!
      else
        warrior.walk!
      end

    else

      if warrior.feel.captive?
        warrior.rescue!
      else
        warrior.attack!
      end

    end

    @health = warrior.health

  end
end
