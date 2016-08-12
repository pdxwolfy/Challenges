class DNA
  def initialize(strand)
    @strand = strand.chars
  end

  def hamming_distance(other_strand)
    pairs = @strand.zip(other_strand.chars).take_while { |_, other| other }
    mutations = pairs.reject do |original_base, other_base|
      original_base == other_base
    end
    mutations.size
  end
end
