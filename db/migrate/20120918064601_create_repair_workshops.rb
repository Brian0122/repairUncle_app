class CreateRepairWorkshops < ActiveRecord::Migration
  def change
    create_table :repair_workshops do |t|
      t.integer :repair_id
      t.integer :workshop_id

      t.timestamps
    end
  end
end
