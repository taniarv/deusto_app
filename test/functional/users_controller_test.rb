require File.dirname(File.expand_path(__FILE__)) + "/../test_helper"

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "logged in user should see users list" do
    login_as(:homer)
    get :index

    assert_response :success
    assert assigns(:users)
    assert !assigns(:users).empty? 
  end

  test "anonymous user should be redirected to login page when getting index" do
    get :index

    assert_redirected_to login_path
    assert_equal "You need to be logged in in order to see the users list", flash[:notice]
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => {:name => 'Alice', :email => 'alice@email.com', :password => '123456', :password_confirmation => '123456'}
    end

    assert_redirected_to user_path(assigns(:user))
  end
  
  test "should not create invalid user" do
    assert_no_difference('User.count') do
      post :create, :user => {:name => 'Alice', :email => 'invalid', :password => '123456', :password_confirmation => '123456'}
    end
    assert_template 'users/new'
  end  

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: @user.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
    
end
