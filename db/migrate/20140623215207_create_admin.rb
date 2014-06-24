class CreateAdmin < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.belongs_to :user
      t.timestamps
    end
  end
end
