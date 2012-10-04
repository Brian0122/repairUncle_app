class RemoveIdFromRepairWorkshops < ActiveRecord::Migration
  def self.up
  	remove_column :repair_workshops, :id
  end

  def self.down
  end
end
