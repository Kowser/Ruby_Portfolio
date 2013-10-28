def title_case(string)
  new_string = []
  string.split.each do |word|
    if is_exception(word) == true && string.index(word) != 0
      new_string << word
    else
      new_string << word[0].upcase + word[1..-1]
    end
  end
  new_string.join(" ")
end

def is_exception(word)
  exceptions = ["a","an","as","and","at","but","by","for","from","if","in","into","nor","of","or","per","the","this","to","with"]
  exceptions.include?(word)
end
