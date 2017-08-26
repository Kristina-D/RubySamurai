#Lesson1-Task2 Triangle
print "Enter the base of triangle: "
triangle_base = gets.chomp.to_f

print "Enter the height of triangle: "
triangle_height = gets.chomp.to_f

triangle_area = triangle_base*triangle_height/2
puts "The triangle area is #{triangle_area}"