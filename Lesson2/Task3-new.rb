#Task 3 - Fibonacci number
my_array = []
i = 0
n = 1
sum = 0

while sum + i < 100
  sum += i 
  i = n
  n = [i, sum].max
  my_array.push(n)
end

puts my_array

#another way
my_array2 = [1, 1]

puts "Or in another way:"

loop do
  i = my_array2[-2] + my_array2[-1]
  break if i > 100
  my_array2<<i
end

puts my_array2


puts "3rd way"
my_array3 = [1, 1]

while (i = my_array3[-2] + my_array3[-1]) < 100
  my_array3<<i
end

puts my_array3


