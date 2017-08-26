#Lask 4 - Alphabet

characters_range = ('А'..'Я')
vowels_array = %w(А Е И О У Ы Э Ю Я)
my_hash = {}

characters_range.each_with_index do |letter, index|
  if vowels_array.include?(letter)
    my_hash.merge!({index+1 =>letter})
    #either:
    puts "#{index+1} - #{letter}"
  end
end

#either:
puts "Гласные  буквы:"

my_hash.each do |letter, number|
  puts "#{letter} - #{number}"
end



