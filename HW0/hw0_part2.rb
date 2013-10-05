def hello(name)
  "Hello, #{name}"
end

def starts_with_consonant?(s)
if /\A[^aeiouAEIOU\d\W]/.match(s) == nil 
    false 
   else
    true
  end

end

def binary_multiple_of_4?(s)
  return false unless /[^0-1]/.match(s) == nil
  #transformar a decimal.
  d = s.to_i(2)
  #averiguar si es multiplo de 4
  d % 4 == 0 && d != 0  ? true : false
end