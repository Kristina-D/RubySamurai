#Task 5 - Year

print "Please enter the day: "
user_day = gets.to_i

print "Please enter the month: "
user_month = gets.to_i

print "Please enter the year: "
user_year = gets.to_i

number = 0

i = 0
days_in_month = [31,28,31,30,31,30,31,31,30,31,30,31]

if ((user_year % 4 == 0) && (user_year % 100 != 0)) || (user_year % 100 == 400)
  array_year[1] = 29
end

if user_month > 1
  while i < user_month - 1
    number += days_in_month[i]
    i += 1
  end
end

number = number + user_day

puts "The serial numer of date is #{number}."