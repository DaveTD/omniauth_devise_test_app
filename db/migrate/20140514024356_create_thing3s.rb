class CreateThing3s < ActiveRecord::Migration
  def change
    create_table :thing3s do |t|

      t.string :thing_name
      t.string :thing_description

      t.timestamps
    end
  end
end
