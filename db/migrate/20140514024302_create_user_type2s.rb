class CreateUserType2s < ActiveRecord::Migration
  def change
    create_table :user_type2s do |t|
      t.belongs_to :user

      t.string :location

      t.timestamps
    end
  end
end
