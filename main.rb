# frozen_string_literal: true

tmp = ''

while tmp.chomp != 'exit'
  print "What does thou doest?\n)"
  tmp = gets
  parsed = tmp.split(' ')
  puts "action: #{parsed.first}"
  puts "object: #{parsed[1]}"
end
