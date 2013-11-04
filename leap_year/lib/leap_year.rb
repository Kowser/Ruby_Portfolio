def leap_year(year)
  if is_valid_integer(year)
    if year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
      true
    else
      false
    end
  else
    false
  end
end

def is_valid_integer(year)
  if year > 0 && year % 1 == 0
    true
  else
    false
  end
end
