class CreateBlacklistStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :blacklist_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
