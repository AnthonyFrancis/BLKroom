require 'test_helper'

class PostMailerTest < ActionMailer::TestCase
  test "new_response" do
    mail = PostMailer.new_response
    assert_equal "New response", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
