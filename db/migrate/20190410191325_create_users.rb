class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.references :role, foreign_key: true
      t.references :location, foreign_key: true
      t.references :geofence, foreign_key: true
      t.string :username
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
