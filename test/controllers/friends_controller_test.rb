require 'test_helper'

class FriendsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:oscar)
    @user2 = users(:maria)
  end


  test "match notification email" do
    #log in user 1 and like user 2
    sign_in @user
    assert_difference "Like.count", 1 do
      post :like, { liked: true, id: @user2 }
    end
    sign_out @user

    #log in user 2 and like user 1
    sign_in @user2
    assert_difference "Like.count", 1 do
      post :like, { liked: true, id: @user }
    end
    assert_template 'friends/match'
    # a message was sent
    assert_equal 1, ActionMailer::Base.deliveries.size
  end

end
