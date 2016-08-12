text = <<eof
Then Almitra spoke again and said, "And what of Marriage, master?" And he answered saying: You were born together, and together you shall be forevermore. You shall be together when white wings of death scatter your days. Aye, you shall be together even in the silent memory of God. But let there be spaces in your togetherness, And let the winds of the heavens dance between you. Love one another but make not a bond of love: Let it rather be a moving sea between the shores of your souls. Fill each other's cup but drink not from one cup. Give one another of your bread but eat not from the same loaf. Sing and dance together and be joyous, but let each one of you be alone, Even as the strings of a lute are alone though they quiver with the same music. Give your hearts, but not into each other's keeping. For only the hand of Life can contain your hearts. And stand together, yet not too near together: For the pillars of the temple stand apart, And the oak tree and the cypress grow not in each other's shadow.
eof

def clean_word(word)
  word.sub(/\A[-']/, '').sub(/[-']\Z/, '').gsub(/[^-'a-z]/i, '')
end

def word_key(word, keys)
  key_for_word = keys.find { |key| key.downcase == word.downcase }
  key_for_word || word
end

def word_count(txt)
  txt.split.each_with_object(Hash.new(0)) do |word, count|
    word = clean_word(word)
    next if word.empty?
    key = word_key(word, count.keys)
    count[key] += 1
  end
end

word_count(text).each_pair do |word, count|
  puts "#{word} -> #{count}"
end
