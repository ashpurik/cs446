class Player

  @health = nil
  MINIMUM = 8
  MAXIMUM = 20
  @saved = nil
  @turned = nil


  def play_turn(warrior)

    @health = warrior.health unless @health != nil
    @saved = false unless @saved != nil
    @turned = false unless @turned != nil

    if warrior.feel.wall?
      warrior.pivot! :backward
      @saved = true

    elsif warrior.feel(:backward).wall?
      @saved = true
      warrior.walk!

    elsif warrior.look(:backward).any? { |space| space.enemy? } && @turned == false
      warrior.pivot! :backward
      @turned = true

    elsif warrior.look.all? { |space| space.empty? }
      if @turned == true
        warrior.walk!
      end 
      #warrior.pivot! :backward

    #CAPTIVES AHEAD
    elsif (warrior.look.any? { |space| space.captive? }) 

      if warrior.feel.captive?
        warrior.rescue!
        @saved = true
      else
        warrior.walk!
      end
      
    #WIZARDS  
    elsif (warrior.look.any? { |space| space.enemy? })
      warrior.shoot!

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