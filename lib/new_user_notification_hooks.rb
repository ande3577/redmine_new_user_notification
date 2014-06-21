class NewUserNotificationHooks < Redmine::Hook::ViewListener
  render_on :view_my_account, :partial => 'account_settings/new_user_notification_account_settings', :layout => false
end
