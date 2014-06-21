require_dependency 'new_user_notification_hooks'
require_dependency 'new_user_notification_user_patch'
require_dependency 'new_user_notification_mailer_patch'

Redmine::Plugin.register :redmine_new_user_notification do
  name 'Redmine New User Notification plugin'
  author 'David S Anderson'
  description 'Allows an admin user to receive a notification email when a new user is created.'
  version '0.0.1'
  url 'https://github.com/ande3577/redmine_new_user_notification'
  author_url 'https://github.com/ande3577'
end
