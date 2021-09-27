require "test_helper"

class TaggingTest < ActiveSupport::TestCase
  def setup
    @tag = Tag.create(name: "docker")
    @user = User.create(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
    @article = @user.articles.build(title: "test article", body: "this is test.", is_visible: true)
    @article.save
    @tagging = Tagging.new(tag_id: @tag.id, article_id: @article.id)
  end

  test "should be valid" do
    assert @tagging.valid?
  end
end
