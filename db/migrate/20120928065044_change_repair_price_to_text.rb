class ChangeRepairPriceToText < ActiveRecord::Migration
  def self.up
  	change_column :repairs, :price , :text
  end

  def self.down
  end
end
