#Define a method sum which takes an array of integers as an argument and returns the sum of its elements. 
#For an empty array it should return zero.
    def sum(array=[])
    	return 0 if array.size == 0
    	suma = 0
    	array.each{ |elt| suma += elt.to_i }
    	suma 
    end
    
#Define a method max_2_sum which takes an array of integers as an argument and 
#returns the sum of its two largest elements. For an empty array it should return zero. 
#For an array with just one element, it should return that element.
    def max_2_sum(array=[])
    	return 0 if array.empty?
    	return array[0] if array.size == 1
    	p array.sort!
    	array[-2] + array[-1]
    end

#Define a method sum_to_n? which takes an array of integers and an additional integer, n, 
# as arguments and returns true if any two elements in the array of integers sum to n. 
# An empty array should sum to zero by definition.
def sum_to_n?(array=[0],n="nada")
 return true if array == [] && n == 0
 array.each_index do |i|
  	array.each_index do |j|
  		return true if i != j && array[i] + array[j] == n
  	end
  end
  false
end

#returns true for the empty array with zero argument
#p sum_to_n?([], 0)