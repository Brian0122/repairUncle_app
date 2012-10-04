class CreateRepairs < ActiveRecord::Migration
  def change
    create_table :repairs do |t|
      t.string :name
      t.string :parts
      t.string :terms
      t.float :price
      t.integer :model_id

      t.timestamps
    end
  end
end
