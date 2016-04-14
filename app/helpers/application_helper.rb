module ApplicationHelper

  def plural(n, one, few, many)
    return 'ни одного' if n.nil?
    n % 10 == 1 && n % 100 != 11 ? one : [2, 3, 4].include?(n % 10) && ![12, 13, 14].include?(n % 100) ? few : n % 10 == 0 || [5, 6, 7, 8, 9].include?(n % 10) || [11, 12, 13, 14].include?(n % 100) ? many : few
  end

  def day_left(today, day_start)



  end

end
