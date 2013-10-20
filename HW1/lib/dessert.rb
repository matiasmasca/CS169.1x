=begin
    Create a class Dessert with getters and setters for name and calories. The
    constructor should accept arguments for name and calories. 

    Define instance methods healthy?, which returns true if and only if a dessert has less than
    200 calories, and delicious?, which returns true for all desserts. 



    Create a class JellyBean that inherits from Dessert. The constructor should accept a
    single argument giving the jelly bean's flavor; a newly-created jelly bean
    should have 5 calories and its name should be the flavor plus "jelly bean",
    for example, "strawberry jelly bean". 

    Add a getter and setter for the flavor. Modify delicious? to return false if the flavor is licorice, but
    true for all other flavors. The behavior of delicious? for non-jelly-bean
    desserts should be unchanged.
=end
class Dessert
  attr_accessor :name , :calories
  def initialize(name, calories)
    @name = name
    @calories = calories
  end
  def healthy?
    true if @calories <= 200
  end
  def delicious?
    true
  end
end

class JellyBean < Dessert
  attr_accessor :flavor
  def initialize(flavor)
    @flavor = flavor
    @calories = 5 
    @name = "#{flavor} jelly bean"
  end
  def delicious?
     if @flavor.include?("licorice")
       false
     else
      true
    end
  end
end