class CreateThing2s < ActiveRecord::Migration
  def change
    create_table :thing2s do |t|

      t.string :thing_name
      t.string :thing_description
      t.string :thing_equipment

      t.integer :thing_stat

      t.timestamps
    end
  end
end
