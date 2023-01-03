def reduce(arr)
  total = nil
  
  case
  when arr[0].class == String then total = ''
  when arr[0].class == Integer then total = 0
  when arr[0].class == Array then total = []
  end
  
  arr.each do |num|
    total = yield(total, num)
  end

  total
end

array = ['a', 'b', 'c']

# p reduce(array) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']