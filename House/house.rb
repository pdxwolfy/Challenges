class House
  def self.recite
    House.new.verses.join "\n"
  end

  def verses
    1.upto(pieces.size).map do |verse_number|
      phrases = verse verse_number
      phrases.join("\n") + ".\n"
    end
  end

  private

  def verse verse_number
    components = ['This is'] + pieces.last(verse_number).flatten
    components.each_slice(2).map { |pair| pair.join ' ' }
  end

  def pieces
    [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built']
    ]
  end
end
