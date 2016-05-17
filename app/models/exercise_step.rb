class ExerciseStep < ActiveRecord::Base

  belongs_to :exercise
  validates :title, presence: true

end