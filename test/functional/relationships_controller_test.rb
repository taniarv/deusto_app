require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  test "should create a relationship" do
     login_as(:homer)

     assert_difference("Relationship.count", 1) do
       post :create, :relationship => {followed_id: users(:krusty).id}
     end

     assert_redirected_to user_path(users(:krusty))
   end

   test "should destroy relationship" do
     login_as(:homer)

     assert_difference("Relationship.count", -1) do
       delete :destroy, :id => relationships(:homer_follows_moe).id
     end

     assert_redirected_to user_path(users(:moe))
   end
   
   test "should create a relationship using Ajax" do
     login_as(:homer)
    
     assert_difference("Relationship.count", 1) do
       xhr :post, :create, :relationship => {:followed_id => users(:krusty).id}
     end
    
     assert_response :success
   end
end
