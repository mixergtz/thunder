require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "welcome" do
    # create user
    @user = User.create(name: "Test User", email: "test@example.com",
                       encrypted_password: "foobar12", age: "22")

    # Send the email, then test that it got queued
    email = UserMailer.welcome_email(@user).deliver
    assert_not ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal ['hello@mxr-fzone.herokuapp.com'], email.from
    assert_equal ['test@example.com'], email.to
    assert_equal 'Bienvenido a FZone', email.subject
  end

  test "match email" do

    # Send the email, then test that it got queued
    email = UserMailer.notify_match(users(:oscar), users(:maria)).deliver
    assert_not ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal ['hello@mxr-fzone.herokuapp.com'], email.from
    assert_equal ['orendon@gmail.com', "example@example.com"], email.to
    assert_equal 'Tienes una coincidencia en FZone', email.subject
  end

end