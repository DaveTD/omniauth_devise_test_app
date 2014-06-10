class CreateThing1s < ActiveRecord::Migration
  def change
    create_table :thing1s do |t|

      t.string :thing_name
      t.string :thing_description

      t.integer :thing_stat
      t.integer :thing_other_stat

      t.datetime :thing_occurrance_date

      t.timestamps
    end
  end
end
