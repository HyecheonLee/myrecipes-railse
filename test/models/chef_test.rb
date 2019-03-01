require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @chef = Chef.new(chefname: "hyecheon", email: "hyecheon@example.com")
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  test "should be vaild" do
    assert @chef.valid?
  end
  test "name should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  test "name should be less than 30 characters" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end
  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  test "email should acccept be correct format" do
    valid_emails = %w[user@example.com hyecheon@gmail.com M.first@yahoo.ca jhon+smith@co.uk.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end
  test "should reject invalid address" do
    invalid_emails = %w[hyecheon@example hyecheon@example,com hyecheon.name@gmail.]
    invalid_emails.each do |invalids|
      @chef.email = invalids
      assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
    end
  end
  test "email should be unique and case insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end
  test "email should be lower case before hitting db" do
    mixed_email = "John@example.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email

  end
end