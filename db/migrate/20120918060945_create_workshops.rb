class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :name
      t.string :address
      t.string :contact_person
      t.string :contact_numbers
      t.string :website
      t.string :opening_hours
      t.boolean :is_premium

      t.timestamps
    end
  end
end
