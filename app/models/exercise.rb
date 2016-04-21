class Exercise < ActiveRecord::Base
  belongs_to :unit
  has_many :day_exercises
  has_and_belongs_to_many :program_days, :class_name => 'ProgramDay', :join_table => :day_exercises
  has_and_belongs_to_many :equipment

  validates :title, presence: true
end
