# frozen_string_literal: true

class String
  # Change the case of characters randomly
  # @return [String] the case modified string
  # @example
  #   'SELECT * FROM'.randomcase # => "SElECt * frOm"
  #   'SELECT * FROM'.randomcase # => "selECT * FROm"
  def randomcase
    chars.map { |c| rand(0..1).zero? ? c.downcase : c.upcase }.join
  end

  # Change the case of characters randomly in place as described for
  # {String#randomcase}.
  def randomcase!
    replace(randomcase)
  end

  # Change one characte on two upcase and the other downcase
  # @param shift [Integer] 0: 1st character will be downcase, 1: 1st character
  #   will be upcase
  # @return [String] the case modified string
  # @example
  #   'SELECT * FROM'.alternatecase # => "sElEcT * FrOm"
  #   'SELECT * FROM'.alternatecase(1) # => "SeLeCt * fRoM"
  def alternatecase(shift = 0)
    chars.each_with_index.map { |c, i| (i + shift).even? ? c.downcase : c.upcase }.join
  end

  # Change one characte on two upcase and the other downcase in place as
  # described for {String#alternatecase}.
  def alternatecase!(shift = 0)
    replace(alternatecase(shift))
  end
end
