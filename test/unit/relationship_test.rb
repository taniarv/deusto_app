require File.dirname(File.expand_path(__FILE__)) + "/../test_helper"

class RelationshipTest < ActiveSupport::TestCase
  
  test "relationship has follower and followed" do
    rel = relationships(:homer_follows_moe)
    assert_equal users(:homer), rel.follower
    assert_equal users(:moe), rel.followed
  end
  
end
