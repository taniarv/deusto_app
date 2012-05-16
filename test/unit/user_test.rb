# encoding: UTF-8
require File.dirname(File.expand_path(__FILE__)) + "/../test_helper"

class UserTest < ActiveSupport::TestCase
def setup
    @default_attributes = {:name => "Lisa Simpson", 
                           :email => "lisa@simpsons.org", 
                           :password => "saxophone"}
  end
  
  test "should save record with all valid attributes" do
    user = User.new(@default_attributes)
    assert user.valid?, 'Usuario válido'
  end
  
  test "should not save record with empty name" do
    user = User.new(@default_attributes.merge(:name => nil))
    assert !user.valid?
    assert user.errors[:name].include?("can't be blank")
  end
  
  test "should not save record with empty email" do
    user = User.new(@default_attributes.merge(:email => nil))
    assert !user.valid?
    assert user.errors[:email].include?("can't be blank")
  end

  test "should not save record with invalid email" do
    user = User.new(@default_attributes.merge(:email => "invalid"))
    assert !user.valid?
    assert user.errors[:email].include?("is invalid")
  end
  
  test "should not save record with duplicated email address" do
    user1 = User.create!(@default_attributes)
    user2 = User.new(@default_attributes)
    assert !user2.valid?
    assert user2.errors[:email].include?("has already been taken")
  end

  test "should respond to followings" do
    user = users(:homer)
    assert_equal [users(:moe)], user.followings
  end
  
  test "should respond to follows?" do
    user = users(:homer)
    
    assert user.follows?(users(:moe))
  end

  test "should follow" do
    user = users(:homer)

    assert_difference("Relationship.count", 1) do
      user.follow!(users(:moe))
    end

    assert user.followings.include?(users(:moe))
  end

  test "should unfollow" do
    user = users(:homer)

    assert_difference("Relationship.count", -1) do
      user.unfollow!(users(:moe))
    end

    assert user.followings.empty? 
  end
end
