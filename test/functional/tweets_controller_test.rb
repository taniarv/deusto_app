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
  
  test "logged in user sees the tweets of the users she follows" do
    login_as(:homer)
    current_user = users(:homer)
    assert current_user.follows?(users(:moe))
    assert !current_user.follows?(users(:one))    
    
    get :index
    assert_response :success
    assert assigns(:tweets)
    
    assert_nil assigns(:tweets).detect {|t| t.user.eql?(users(:one))}
    assert_not_nil assigns(:tweets).detect {|t| t.user.eql?(users(:moe))}    
  end
     
end
