def leap_year(year)
  if year % 400 == 0
    true
  elsif year % 100 == 0 
    false
  elsif year % 4 == 0
    true
  else
    false
  end
end

def is_positive_integer(year)
  if year <= 0
    false
  elsif year % 1 != 0
    false
  end
end
