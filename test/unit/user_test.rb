require File.expand_path('../../test_helper', __FILE__)

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def setup
    @user = User.active.where(:admin => true).first
    ActionMailer::Base.deliveries.clear
  end

  def teardown
    @new_user.destroy if @new_user
  end

  def test_send_email_when_new_user_created
    set_notify_for_new_user(true)    
    create_user()
    assert notify?
  end

  def test_do_not_notify_if_user_is_does_not_have_preference_set
    set_notify_for_new_user(false)
    create_user()
    assert !notify?
  end

  def test_do_not_notify_if_user_is_not_admin
    @user.admin = false
    set_notify_for_new_user(true)
    create_user()
    assert !notify?
  end

  private
  def create_user()
    @new_user = User.new(:firstname => "new", :lastname => "user", :mail => "newuser@somenet.foo")
    @new_user.login = "newuser"
    @new_user.password, @user.password_confirmation = "password", "password"
    @new_user.save!
  end

  def set_notify_for_new_user(notify, user = @user)
    user.pref[:notify_for_new_user] = notify
    user.save!
    user.pref.save!
    user.reload
  end

  def notify?(user = @user)
    delivery = ActionMailer::Base.deliveries.last
    return false if delivery.nil?
    mail = user.mail
    delivery.to.include?(mail) or delivery.cc.include?(mail) or delivery.bcc.include?(mail)
  end

end