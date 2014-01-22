#I use instance variables to keep track whether or not
#the warrior has turned around yet (@turned) and to keep track
#of the actual warrior (@warrior). 

#I use a class variable to keep track of the warrior's previous health

#I use a constant to keep track of the minimum health my warrior
#should have to avoid dieing

#I use the rubywarrior array that is returned from warrior.look. 
#This method returns an array of size 3, with 3 spaces. I go 
#through each space, checking if it is a captive or an enemy

#I use the hash function when I turn the warrior around, by passing
#in ":backward" to the pivot! function. :backward is the key in the
#hash and the value is what causes the warrior to turn in the 
#correct direction

#I use lots of functions to make the code cleaner in the play_turn function

class Player

  @@health = nil
  MINIMUM = 8
  @turned = nil
  @warrior = nil


  def play_turn(warrior)

    #this variable keeps track if the warrior has turned around
    @turned = false unless @turned != nil
    @warrior = warrior unless @warrior != nil
    @@health = warrior.health unless @@health != nil

    #if there is an enemy or captive behind the warrior 
    #and the warrior hasn't turned around yet, then the
    #warrior is going to turn around
    if (enemy_behind? || captive_behind?) && @turned == false
      warrior.pivot! :backward
      @turned = true

    #if there is a wall in front of you, turn around
    elsif wall_in_front?
      warrior.pivot! :backward

    elsif found_captive?
      warrior.rescue!

    #if you aren't under attack and have low health, rest
    elsif !under_attack? && warrior.health <= MINIMUM
      warrior.rest!

    elsif enemy_ahead?
      warrior.shoot!

    else
      warrior.walk!
      
    end

    #save your previous health
    @@health = warrior.health
    
  end
  

  def enemy_behind?
    @warrior.look(:backward).any? { |space| space.enemy? }
  end

  def captive_behind?
    @warrior.look(:backward).any? { |space| space.captive? }
  end

  def wall_in_front?
    @warrior.feel.wall?
  end

  def enemy_ahead?
    @warrior.look.any? { |space| space.enemy? }
  end

  def captive_ahead?
    @warrior.look.any? { |space| space.captive? }
  end

  def found_captive?
    @warrior.feel.captive?
  end

  def under_attack?
    @warrior.health < @@health
  end


end