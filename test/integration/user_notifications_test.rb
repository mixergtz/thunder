require 'test_helper'

class UserNotificationsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "sign up mail" do
    #sign up user
    get new_user_registration_path
    assert_difference "User.count", 1 do
      post_via_redirect user_registration_path, user: { email: "alguien@algo.com",
                                            name: "Pepito Perez",
                                            age: 25,
                                            password: "12345678",
                                            password_confirmation: "12345678" }
    end
    # a message was sent
    assert_equal 1, ActionMailer::Base.deliveries.size
  end


end
