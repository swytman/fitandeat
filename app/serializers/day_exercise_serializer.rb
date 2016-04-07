class DayExerciseSerializer < ActiveModel::Serializer
  attributes :title, :order, :description

  def title
    return unless object.title
    result = "#{object.exercise.title}"
    if object.count? && object.count > 0
      result = "#{result} - #{object.count}"
    end
    result
  end

end