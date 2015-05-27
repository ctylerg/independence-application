class Game < ActiveRecord::Base

  belongs_to(:season)
  
  def to_s
    self.name
  end
end
