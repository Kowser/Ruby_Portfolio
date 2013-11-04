$digits = {
  1 => 'one',
  2 => 'two',
  3 => 'three',
  4 => 'four',
  5 => 'five',
  6 => 'six',
  7 => 'seven',
  8 => 'eight',
  9 => 'nine',
  10 => 'ten',
  11 => 'eleven',
  12 => 'twelve',
  13 => 'thirteen',
  14 => 'fourteen',
  15 => 'fifteen',
  16 => 'sixteen',
  17 => 'seventeen',
  18 => 'eighteen',
  19 => 'nineteen'
}

$tens = {
  1 => 'ten',
  2 => 'twenty',
  3 => 'thirty',
  4 => 'forty',
  5 => 'fifty',
  6 => 'sixty',
  7 => 'seventy',
  8 => 'eighty',
  9 => 'ninety'
}

$scales = {
 1 => 'thousand',
 2 => 'million',
 3 => 'billion',
 4 => 'trillion',
 5 => 'quadrillion',
 6 => 'quintillion',
 7 => 'sextillion',
 8 => 'septillion',
 9 => 'octillion'
}

$answer = []
$i = 1

def less_than_twenty(number)
  unless number == 0
    $answer.push($digits[number])
  end
end

def less_than_hundred(number)
  if number < 20
    less_than_twenty(number)
  elsif number % 10 == 0
    $answer.push($tens[number / 10])
  else
    $answer.push($tens[number / 10] + " " + $digits[number % 10])
  end
end

def less_than_thousand(number)
  if number < 100
    less_than_hundred(number)
  elsif number % 100 == 0
    $answer.push($digits[number / 100] + " hundred")
  else
    less_than_hundred(number % 100)
    $answer.push($digits[number / 100] + " hundred")
  end
end

def numbers_to_words(number)
  if number < 1000
    less_than_thousand(number)
  else 
    less_than_thousand(number % 1000)
    $answer.push($scales[$i])
    $i += 1
    numbers_to_words(number / 1000)
  end
end
