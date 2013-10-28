$sequence = [0,1]

def fibonacci(index)
index -= 1
  if index >= 2
    $sequence.push($sequence[$sequence.length - 2] + $sequence[$sequence.length - 1])
    fibonacci(index)
  end
  $sequence[index]
end
