#Task 5 - Year

print "Please enter the day: "
day = gets.to_i

print "Please enter the month: "
month = gets.to_i

print "Please enter the year: "
year = gets.to_i

number = day
i = 0

days_in_month = [31,28,31,30,31,30,31,31,30,31,30,31]

if ((year % 4 == 0) && (year % 100 != 0)) || (year % 100 == 0)
  days_in_month[1] = 29
  puts "hey"
end

while i < month - 1
  number += days_in_month[i]
  i += 1
  puts number
end

puts "The serial numer of date is #{number}."