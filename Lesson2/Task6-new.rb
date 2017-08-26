#Task 6 - Summa pokupok
total = 0
basket = {}

loop do
  print "Please enter stop if you want to stop: "
  command = gets.chomp
  break if command.downcase == 'stop'
  
  print "enter the name of product: "
  product_name = gets.chomp
  
  print "enter the price: "
  product_price = gets.chomp.to_f
  
  print "enter the quantity: "
  product_quantity = gets.chomp.to_f
  
  basket[product_name] = { quantity: product_quantity, price: product_price }
  sum_price = product_price*product_quantity
  puts "This purchase costs #{sum_price}"
  
  total += sum_price
end

puts "The total amount is : #{total}"
