class ChangeBlacklistedUsersToBlacklistRecords < ActiveRecord::Migration[5.2]
  def change
    rename_table :blacklisted_users, :blacklist_records
  end
end
