class ProgramDay < ActiveRecord::Base
  belongs_to :program
  has_many :day_exercises
  has_and_belongs_to_many :exercises, :class_name => 'Exercise', :join_table => :day_exercises
end
