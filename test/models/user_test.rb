require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "Example Name", email: "example@email.com",
			password: "foobar", password_confirmation: "foobar")
	end

	test "valid user should be valid" do
		assert @user.valid?
	end
  
	test "name should not be blank" do
		@user.name = "     "
		assert_not @user.valid?
	end

	test "email should not be blank" do
		@user.email = "     "
		assert_not @user.valid?
	end

	test "name should not be too long" do
		@user.name = "a" * 51
		assert_not @user.valid?
	end

	test "email should not be too long" do
		@user.name = "a" * 244 + "@example.com"
		assert_not @user.valid?
	end

	test "correct email formats should be valid" do
		valid_addresses = ["bob@example.com", "foo@bar.ca", "bob+sue@email.com", "bob.smith@email.com"]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?
		end
	end

	test "incorrect email formats should be invalid" do
		invalid_addresses = ["bob@email,com", "bob@e+mail.com"]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?
		end
	end

	test "email should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "password should not be blank" do
		@user.password = @user.password_confirmation = " " * 6
		assert_not @user.valid?
	end

	test "password should be 6 characters or more" do
		@user.password = @user.password_confirmation = "a" * 5
		assert_not @user.valid?
	end

end
