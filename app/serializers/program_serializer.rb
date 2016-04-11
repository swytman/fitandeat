class ProgramSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  has_many :program_days

  def program_days
    object.program_days.order('program_days.order ASC')
  end

end