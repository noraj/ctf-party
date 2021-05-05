# frozen_string_literal: true

class String
  # Remove leading and trailing whitespace (like {String#strip}) but also all
  # inner whitespace.
  # @return [String] the whitespace-free string
  # @example
  #   "\t\n\v\f\r Hello \t\n\v\f\r World !\t\n\v\f\r ".istrip # => "HelloWorld!"
  #   '73 74 72 69 70'.istrip # => "7374726970"
  def istrip
    strip.gsub(/\s/, '')
  end

  # Remove all whitespace in place as described for {String#istrip}.
  def istrip!
    replace(innerstrip)
  end
end
