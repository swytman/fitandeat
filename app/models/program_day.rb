class ProgramDay < ActiveRecord::Base
  include Serializeable
  belongs_to :program
  has_many :day_exercises
  has_and_belongs_to_many :exercises, :class_name => 'Exercise', :join_table => :day_exercises

  def clone_day
    new_item = program.program_days.create({order: program.program_days.count+1})

    day_exercises.each do |exercise|
      new_exercise = exercise.dup
      new_exercise.program_day_id = new_item.id
      new_exercise.save
    end

    return new_item

  end

end
