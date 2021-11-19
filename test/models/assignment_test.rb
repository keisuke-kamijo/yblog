require "test_helper"

class AssignmentTest < ActiveSupport::TestCase
  def setup
    @user = User.create(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
    @article = Article.create(title: "test article", body: "this is test.", user_id: @user.id, is_visible: true)
    @list = List.create(name: "Test List", is_placed: false, user_id: @user.id)
    @assignment = Assignment.create(list_id: @list.id, article_id: @article.id, rank: 1)
  end

  test "should be valid" do
    assert @assignment.valid?
  end

  test "list_id should be present" do
    @assignment.list_id = nil
    assert_not @assignment.valid?
  end

  test "assignment_id should be present" do
    @assignment.list_id = nil
    assert_not @assignment.valid?
  end

  test "rank should be present" do
    @assignment.rank = nil
    assert_not @assignment.valid?
  end

  test "associated assignments with lists should be destroyed" do
    assert_difference 'Assignment.count', -1 do
      @list.destroy
    end
  end

  test "associated assignments with articles should be destroyed" do
    assert_difference 'Assignment.count', -1 do
      @article.destroy
    end
  end
end
