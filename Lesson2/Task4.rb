#LTask 4 - Alphabet
#via range:
characters_range = ('А'..'Я')
vowels_array = %w(А Е И О У Ы Э Ю Я)
my_hash = {}
# i = 0

# characters_range.each do |letter|
#   if letter = vowels_array[i]
#     my_hash[i] = letter
#     i+=1 
#   end
# end

# puts "Гласные  буквы:"
# my_hash.each {|key, value| puts "#{value} - #{key}"}

#via each_with_index :
# puts "Гласные  буквы:"
# ["А", "Е", "И", "О", "У", "Ы", "Э", "Ю", "Я"].each_with_index do |value, index|
#   puts "#{value} - #{index}"
# end

i=0
puts "3rd way"
characters_range.each_with_index do |letter, index|
  #vowels_array.each do |vowel|
  key = index
    if vowels_array.include?(letter)
      my_hash.merge!({:key =>letter})
    end
  #end
end

print my_hash


