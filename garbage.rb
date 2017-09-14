
  # def part_of_col_up(starting, ending)
  #   result = []
  #   x = starting[0]
  #   y = starting[1] + 1
  #   while  y < ending[1]
  #     result << @boxes[x][y]
  #     y += 1
  #   end
  #   result
  # end

  def part_of_col_up(starting, ending)
    col(starting[0])[(starting[1] + 1)..(ending[1] - 1)]
  end

  # def part_of_col_down(starting, ending)
  #   result = []
  #   x = starting[0]
  #   y = starting[1] - 1
  #   while y > ending[1]
  #     result << @boxes[x][ y]
  #     y -= 1
  #   end
  #   result
  # end

  def part_of_col_down(starting, ending)
    col(starting[0])[(ending[1] + 1)..(starting[1] - 1)]
  end

  # def part_of_row_right(starting, ending)
  #   result = []
  #   x = starting[1] + 1
  #   y = starting[0]
  #   while x < ending[0]
  #     result << @boxes[x][ y]
  #     x += 1
  #   end
  #   result
  # end

  def part_of_row_right(starting, ending)
    row(starting[1])[(starting[0] + 1)..(ending[0] - 1)]
  end

  # def part_of_row_left(starting, ending)
  #   result = []
  #   x = starting[0] - 1
  #   y = starting[1]
  #   while x > ending[0]
  #     result << @boxes[x][ y]
  #     x -= 1
  #   end
  #   result
  # end

  def part_of_row_left(starting, ending)
    row(starting[1])[(ending[0] + 1)..(starting[0] -1)]
  end

  def part_of_diag_r_up(starting, ending)
    result = []
    x = starting[0] + 1
    y = starting[1] + 1
    while x < ending[0]
      result << @boxes[x][y]
      x += 1
      y += 1
    end
    result
  end

  # def part_of_diag_r_up(starting, ending)
  #   array = diag_r_up(starting[0], starting[1]).select do |position|
  #     position[0] < ending[0]
  #   end
  # end

  def part_of_diag_r_down(starting, ending)
    result = []
    x = starting[0] - 1
    y = starting[1] - 1
    while x > ending[0]
      result << @boxes[x][y]
      x -= 1
      y -= 1
    end
    result
  end
  #
  # def part_of_diag_r_down(starting, ending)
  #   array = diag_r_down(starting[0], starting[1]).select do |position|
  #     position[0] > ending[0]
  #   end
  # end

  def part_of_diag_l_up(starting, ending)
    result = []
    x = starting[0] - 1
    y = starting[1] + 1
    while x > ending[0] && y < ending[1]
      result << @boxes[x][y]
      x -= 1
      y += 1
    end
    result
  end

  # def part_of_diag_l_up(starting, ending)
  #   array = diag_l_up(starting[0], starting[1]).select do |position|
  #     position[0] > ending[0] && position[1] < ending[1]
  #   end
  # end

  def part_of_diag_l_down(starting, ending)
    result = []
    x = starting[0] + 1
    y = starting[1] - 1
    while x < ending[0] && y > ending[1]
      result << @boxes[x][y]
      x += 1
      y -= 1
    end
    result
  end
  #
  # def part_of_diag_l_down(starting, ending)
  #   array = diag_l_down(starting[0], starting[1]).select do |position|
  #     position[0] < ending[0] && position[1] > ending[1]
  #   end
  # end
end
