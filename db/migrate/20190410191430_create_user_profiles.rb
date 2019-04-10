class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.references :user, foreign_key: true
      t.string :picture_path
      t.text :biography

      t.timestamps
    end
  end
end
