#Lesson1-Task4 Quadratic equation
puts "Expression: ах^2 + bx + c = 0"
print "Enter the first coeffecient 'a': "
a = gets.chomp.to_f

print "Enter the second coeffecient 'b': "
b = gets.chomp.to_f

print "Enter the third coeffecient c: "
c = gets.chomp.to_f
puts a, b,  c
discriminant = b**2 - 4*a*c

if discriminant > 0
  c_sqrt = Math.sqrt(discriminant)
  puts " Discriminant  = #{discriminant}, x1 = #{(-b + c_sqrt)/(2*a)}, x2 = #{(-b - c_sqrt)/(2*a)}"
elsif discriminant == 0
  puts " Discriminant  = #{discriminant}, x1 = #{-b/(2*a)}"
elsif discriminant < 0
  puts " Discriminant  = #{discriminant}. No roots."
end