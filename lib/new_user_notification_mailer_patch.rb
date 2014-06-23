module NewUserNotificationMailerPatch
  def self.included(base)
    unloadable
    
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      # Builds a mail for notifying to_users and cc_users about a new issue
      def user_create(user, to, cc)
        redmine_headers 'Login' => user.login,
                        'user-Name' => user.firstname,
                        'Last-Name' => user.lastname,
                        'Email' => user.mail
        message_id user
        references user
        @user = user
        @user_url = url_for(:controller => 'users', :action => 'show', :id => user)
        mail :to => to,
          :cc => cc,
          :subject => l(:text_user_has_created_a_new_account, :name => user.name)
      end

      def self.deliver_user_create(user)
        Mailer.user_create(user, User.notified_addresses_for_new_user, [])
      end
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
  end
  
end

Mailer.send(:include, NewUserNotificationMailerPatch)
