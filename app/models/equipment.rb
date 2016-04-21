class Equipment < ActiveRecord::Base
  has_and_belongs_to_many :exercises
  validates :title, presence: true
end
