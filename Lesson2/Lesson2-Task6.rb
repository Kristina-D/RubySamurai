#Lesson 2 - Summa pokupok
sum_price = 0
total = 0
stop = "i"
basket = Hash.new

until stop == "stop"  do
  print "enter the name of product: "
  product_name = gets.chomp
  
  print "enter the price: "
  product_price = gets.chomp.to_f
  
  print "enter the quantity: "
  product_quantity = gets.chomp.to_f
  
  basket = { :key_name => product_name, :key_buy => { :key_price => product_price, :key_quantity => product_quantity } }
  sum_price = basket [:key_buy][:key_price]*basket [:key_buy][:key_quantity]
  puts "This purchase costs #{sum_price}"

  total += sum_price

  print "enter stop if you want to stop: "

  stop = gets.chomp

end

puts "The total amount is : #{total}"
