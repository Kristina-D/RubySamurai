#Lesson 2 - Fibonacci number
my_array = []
i = 0
n = 1
sum = 0

while sum + i < 100
  sum = sum + i
  i = n
  n = [i, sum].max
  my_array.push(n)
end

puts my_array
