class CreateUserType1s < ActiveRecord::Migration
  def change
    create_table(:user_type1s) do |t|
      t.references :thing, polymorphic: true     
      t.belongs_to :user

      t.string :location
      t.string :name

      t.integer :twitter_uid

      t.timestamps
    end

    add_index :user_type1s, :twitter_uid, unique: true
  end
end
