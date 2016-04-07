class DayExerciseSerializer < ActiveModel::Serializer
  attributes :title, :order, :description

  def title
    result = "#{object.exercise.title}"
    if object.count? && object.count > 0
      result = "#{result} - #{object.count}"
    end
    result
  end

end