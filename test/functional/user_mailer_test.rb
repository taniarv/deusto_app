require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def test_following_email
    follower = users(:moe)
    followee = users(:homer)
    
    # Enviar el email y comprobar que está en la cola
    email = UserMailer.following_email(follower, followee).deliver
    assert !ActionMailer::Base.deliveries.empty?
    
    # Test del contenido del email
    assert_equal [followee.email], email.to
    assert_equal "[DeustoTwitter] #{follower.name} is following you", email.subject
    assert_match(/<h1>Hello, #{followee.name}<\/h1>/, email.encoded)
    assert_match(/Hello, #{followee.name}/, email.encoded)
  end
end
