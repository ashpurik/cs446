class Player

#Set @health to your current health at the end of the turn. If this is greater
#than your current health next turn then you know you're taking damage and
#shouldn't rest.


  @health = nil

  def play_turn(warrior)

    if @health == nil
      @health = warrior.health
    end

    if warrior.feel.empty?

      if warrior.health >= @health && warrior.health < 12
        warrior.rest!
      else
        warrior.walk!
      end

    else
      warrior.attack!
    end

    @health = warrior.health

  end
end
