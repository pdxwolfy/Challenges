# frozen_string_literal: true

require 'english'

module RunLengthEncoding
  REGEX_RUN = %r{
    (?<run>            # Begin character run
      (?<char> . )     # The first character of the run
      \k<char>*        # The rest of the run
    )
  }x

  REGEX_RLE = %r{
    (?<count> \d+)     # The character count
    (?<char> .)        # Character to expand
  }x

  def self.encode plain_text
    plain_text.gsub(REGEX_RUN) do
      length = $LAST_MATCH_INFO[:run].size.to_s
      length = '' if length == '1'
      length + $LAST_MATCH_INFO[:char]
    end
  end

  def self.decode encoded_text
    encoded_text.gsub(REGEX_RLE) do
      $LAST_MATCH_INFO[:char] * $LAST_MATCH_INFO[:count].to_i
    end
  end
end
