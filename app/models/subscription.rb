class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :program

  validates_uniqueness_of :user_id, :scope => :program_id

  def program_day_today
    day_number = (Time.now.to_date - start_date).to_i+1
    count = program.program_days.count
    day_number = day_number % count if program.cycle

    if day_number < 1
      return 0
    end

    if day_number > count
      return -1
    end

    return program.program_days.find_by(order: day_number)

  end

  def program_day_by_order order
    day_number = order.to_i
    count = program.program_days.count
    day_number = day_number % count if program.cycle

    if day_number < 1
      return 0
    end

    if day_number > count
      return -1
    end

    program.program_days.find_by(order: day_number)
  end


end