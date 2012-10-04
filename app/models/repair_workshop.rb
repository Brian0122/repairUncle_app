class RepairWorkshop < ActiveRecord::Base
  attr_accessible :repair,:workshop,:repair_id, :workshop_id
  belongs_to :repair
  belongs_to :workshop

end
