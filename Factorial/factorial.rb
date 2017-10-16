# factorial(n) is defined as n*n-1*n-2..1 for n > 0
# factorial(n) is 1 for n=0
# Let's raise an exception if factorial is negative
# Let's raise an exception if factorial is anything but an integer

def factorial(n)
 if not n.is_a? Integer 
   raise ArgumentError.new("NonInteger") #n is not an integer
 elsif n < 0
   raise ArgumentError.new("Negative") # n is negative
 else
   sum = 1
   while n > 0
    sum *= n
    n -= 1
   end 
   sum
 end
end
