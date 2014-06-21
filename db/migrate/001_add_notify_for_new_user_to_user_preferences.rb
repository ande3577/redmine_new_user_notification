class AddNotifyForNewUserToUserPreferences < ActiveRecord::Migration
  def self.up
     add_column :user_preferences, :notify_for_new_user, :boolean, :default => false
  end
  
  def self.down
    remove_column :user_preferences, :notify_for_new_user
  end
end