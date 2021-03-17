# frozen_string_literal: true

class String
  # Transform into leet speak (l337 5p34k)
  # @example
  #   'The quick brown fox jumps over the lazy dog'.leet # => "7h3 qu1ck 8r0wn f0x jump5 0v3r 7h3 14zy d06"
  #   'leet speak'.leet # => "1337 5p34k"
  def leet
    tr = {
      'T' => '7',
      'E' => '3',
      'I' => '1',
      'L' => '1',
      'O' => '0',
      'S' => '5',
      'A' => '4',
      'G' => '6',
      'B' => '8'
    }
    tr.merge! tr.transform_keys(&:downcase)
    gsub(/[#{tr.keys.join}]/i, **tr)
  end

  # Transform into leet speak (l337 5p34k) in place as described
  # for {String#leet}.
  def leet!
    replace(leet)
  end
end
