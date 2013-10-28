def pig_word(word)
  vowels = ["a", "e", "i", "o", "u"]
  if vowels.include? word[0]
    word + "ay"
  else
    until vowels.include? word[0] || word[0] == "y"
      if word[0] == "q" && word[1] == "u"
        word = word[2..-1] + "qu"
        break
      else
        word = word [1..-1] + word[0]
      end
    end
    word + "ay"
  end
end

def pig_latin(phrase)
  translate = phrase.split(" ")
  translated = []
  translate.each do |word|
    translated << pig_word(word)
  end
  translated.join(" ")
end
