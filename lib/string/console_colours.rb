class String
  def console_colour(colour_code)
    "\e[#{colour_code}m#{self}\e[0m"
  end

  def console_red
    console_colour(CONSOLE_RED)
  end

  def console_green
    console_colour(CONSOLE_GREEN)
  end

  def console_yellow
    console_colour(CONSOLE_YELLOW)
  end

  CONSOLE_RED = 31
  CONSOLE_GREEN = 32
  CONSOLE_YELLOW = 33
end