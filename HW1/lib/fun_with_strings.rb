module FunWithStrings
  def palindrome?
    letters = self.downcase.scan(/\w/)
    letters == letters.reverse
  end
  def count_words
    # your code here
    count_words = {}
    #([a-zA-Z]*[^\W])
    #\b\w+\b
    letters = self.downcase.scan(/\b\w+\b/)
    
    letters.each do |s|
      #Si no esta, entonces agrega.to_sym
      clave = s.to_s
      if count_words[clave] then
          count_words[clave] += 1
        else
          count_words[clave] = 1          
      end 
     
    end 
    return count_words

  end
  def anagram_groups
    grupo = Array.new(0) { Array.new(0) }
    # your code here
    return grupo if self.length == 0
  
  end
end

# make all the above functions available as instance methods on Strings:

class String
  include FunWithStrings
end

p "".anagram_groups