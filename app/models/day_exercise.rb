class DayExercise < ActiveRecord::Base
  include Serializeable
  belongs_to :program_day
  belongs_to :exercise
end
