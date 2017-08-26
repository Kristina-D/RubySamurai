#Lesson 1 - Task Poids Ideal
print "What is you name? "
man_name = gets.chomp
print "What is yuor height? "
man_height = Integer(gets.chomp)
man_weight = man_height - 110
if man_weight >= 0
puts "#{man_name}, your ideal weight is #{man_weight}"
else
	puts "Your weight is already ideal"
end


