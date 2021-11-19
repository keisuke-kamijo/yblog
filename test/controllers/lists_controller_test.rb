require "test_helper"

class ListsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
    @list = List.create(name: "Test List", is_placed: false, user_id: @user.id)
    @another_user = User.create(name: "Another User", email: "another@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should redirect create when not logged in" do
    post "/lists", params:{ name:"Test", is_placed: false, user_id: @user.id }
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@another_user)
    get "/lists/#{@list.id}/edit", params:{ id:@list.id }
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@another_user)
    patch "/lists/#{@list.id}", params:{ id:@list.id, rank: %w(1) }
    assert_redirected_to root_url
  end

  test "should redirect destroy when logged in as wrong user" do
    log_in_as(@another_user)
    delete "/lists/#{@list.id}", params:{ id:@list.id }
    assert_redirected_to root_url
  end
end
