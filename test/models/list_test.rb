require "test_helper"

class ListTest < ActiveSupport::TestCase
  def setup
    @user = User.create(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
    @list = List.create(name: "Test List", is_placed: false, user_id: @user.id)
  end

  test "should be valid" do
    assert @list.valid?
  end

  test "name should be present" do
    @list.name = nil
    assert_not @list.valid?
  end

  test "name should not be too long" do
    @list.name = "a" * 51
    assert_not @list.valid?
  end
end
