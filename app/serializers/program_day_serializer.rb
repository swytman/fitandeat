class ProgramDaySerializer < ActiveModel::Serializer
  attributes :id, :order, :day_exercises

  has_many :day_exercises

  def day_exercises
    object.day_exercises.order('day_exercises.order ASC')
  end

end