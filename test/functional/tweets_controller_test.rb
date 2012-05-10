require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  setup do
    @tweet = tweets(:user_one_tweet)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tweets)
  end

  test "should get new" do
    get :new
    assert_redirected_to login_path
    assert_equal 'You need to be logged in in order to tweet', flash[:notice]
  end
  
  test "logged in user should get new" do
    login_as(:one)
    get :new
    assert_response :success
  end  
  
  test "logged in user should create tweet" do
    login_as(:one)
    user_one = users(:one)
    assert_difference('user_one.tweets.count') do
      post :create, :tweet => @tweet.attributes
    end

    assert_redirected_to tweets_path
    assert_equal "Tweet was successfully created.", flash[:notice]
  end
  
  test "anonymous user should be redirected to login page when create tweet" do    
    assert_no_difference('Tweet.count') do
      post :create, :tweet => @tweet.attributes
    end
    assert_equal "You need to be logged in in order to tweet", flash[:notice]
  end
  
    
  # test "should create tweet" do
  #   assert_difference('Tweet.count') do
  #     post :create, tweet: @tweet.attributes
  #   end
  # 
  #   assert_redirected_to tweet_path(assigns(:tweet))
  # end
  # 
  # test "should show tweet" do
  #   get :show, id: @tweet
  #   assert_response :success
  # end
  # 
  # test "should get edit" do
  #   get :edit, id: @tweet
  #   assert_response :success
  # end
  # 
  # test "should update tweet" do
  #   put :update, id: @tweet, tweet: @tweet.attributes
  #   assert_redirected_to tweet_path(assigns(:tweet))
  # end
  # 
  # test "should destroy tweet" do
  #   assert_difference('Tweet.count', -1) do
  #     delete :destroy, id: @tweet
  #   end
  # 
  #   assert_redirected_to tweets_path
  # end
end
