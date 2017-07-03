require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(name: "thai", email: "thai@example.com")
  end

  test 'should be valid' do
    assert @chef.valid?
  end

  test 'name should be present' do
    @chef.name = ""
    assert_not @chef.valid?
  end

  test 'name should be less than 30 characters' do
    @chef.name = 'a' * 31
    assert_not @chef.valid?
  end

  test 'email should be present' do
    @chef.email = ""
    assert_not @chef.valid?
  end

  test 'email should not be more than 245 characters' do
    @chef.email = 'a' * 245 + "@example.com"
    assert_not @chef.valid?
  end

  test 'email should accept correct format' do
    validEmails = %w[user@example.com THAI@gmail.com M.first@yahoo.com josh_smith@co.uk.com]

    validEmails.each do |email|
      @chef.email = email
      assert @chef.valid?, "#{email.inspect} should be valid"
    end
  end

  test 'should reject invalid email' do
    inValidEmails = %w[thai@example thai@gmail. thaigmail.com thai.com]

    inValidEmails.each do |email|
      @chef.email = email
      assert_not @chef.valid? "#{email.inspect} should be invalid"
    end
  end

  test 'email should be unique and case insensitive' do
    duplicateCheft = @chef.dup
    duplicateCheft.email = @chef.email.upcase
    @chef.save
    assert_not duplicateCheft.valid?
  end

  test 'email should be lower case before hitting database' do
    mixedEmails = "johN@exmAple.com"
    @chef.email = mixedEmails
    @chef.save
    assert_equal mixedEmails.downcase, @chef.reload.email
  end

end
