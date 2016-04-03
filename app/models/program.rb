class Program < ActiveRecord::Base
  validates :title, presence: true
  has_many :program_days
end
