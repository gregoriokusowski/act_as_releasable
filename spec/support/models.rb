class Team < ActiveRecord::Base
  has_many :players
  validates_presence_of :name

  act_as_releasable :collections => [:players]
end

class Player < ActiveRecord::Base
  belongs_to :team
  validates_presence_of :name, :skill_level
end
