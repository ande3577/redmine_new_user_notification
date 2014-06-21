module NewUserNotificationUserPatch
  def self.included(base)
    unloadable
    
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      after_create :send_new_user_notification
    end
  end
  
  module ClassMethods
    def notified_addresses_for_new_user
      User.active.where(:admin => true).map{|u| u.mail if u.notify_for_new_user? }
    end
  end
  
  module InstanceMethods
    def send_new_user_notification
      Mailer.deliver_user_create(self).deliver
    end

    def notify_for_new_user?
      pref[:notify_for_new_user]
    end
  end
  
end

User.send(:include, NewUserNotificationUserPatch)