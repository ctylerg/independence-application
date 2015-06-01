class Game < ActiveRecord::Base

  belongs_to(:season)

  def to_s
    self.name
  end


  def self.season(year)
    self.all.where({year: year.to_s})
  end
end
