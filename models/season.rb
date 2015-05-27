class Season < ActiveRecord::Base

  has_many(:games)
  has_many(:teams)

  def to_s
    self.name
  end
end
