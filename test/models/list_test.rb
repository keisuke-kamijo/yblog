require "test_helper"

class ListTest < ActiveSupport::TestCase
  def setup
    @list = List.create(name: "Test List", is_placed: false)
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
