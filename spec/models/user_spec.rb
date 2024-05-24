require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "User Validations" do

    context "testing first_name validation" do

      it "should be valid if :first_name is present" do
        user = User.new(first_name: "This", last_name: "Guy", email: "test@test.com", password: "testing")
        expect(user).to be_valid
        expect(user[:first_name]).to eql("This")
      end

      it "should NOT be valid if :first_name is NOT present" do
        user = User.new(first_name: nil, last_name: "Guy", email: "test@test.com", password: "testing")
        expect(user).to_not be_valid
        expect(user.errors[:first_name]).to include("can't be blank")
      end

    end

    context "testing last_name validation" do

      it "should be valid if :last_name is present" do
        user = User.new(first_name: "This", last_name: "Guy", email: "test@test.com", password: "testing")
        expect(user).to be_valid
        expect(user[:last_name]).to eql("Guy")
      end

      it "should NOT be valid if :last_name is NOT present" do
        user = User.new(first_name: "This", last_name: nil, email: "test@test.com", password: "testing")
        expect(user).to_not be_valid
        expect(user.errors[:last_name]).to include("can't be blank")
      end

    end

    context "testing email validation" do

      it "must be valid if a valid :email is provided" do
        user = User.new(first_name: "This", last_name: "Guy", email: "test@test.com", password: "testing")
        expect(user).to be_valid
        expect(user[:email]).to eql("test@test.com")
      end

      it "must NOT be valid if an invalid :email is provided" do
        user = User.new(first_name: "This", last_name: "Guy", email: "invalid-email", password: "testing")
        expect(user).to_not be_valid
        expect(user.errors[:email]).to include("is invalid")
      end

      it "must NOT be valid if a duplicate :email is provided" do
        User.create(first_name: "This", last_name: "Guy", email: "test@test.com", password: "testing")
        duplicate_user = User.new(first_name: "That", last_name: "Person", email: "test@test.com", password: "password")
        expect(duplicate_user).to_not be_valid
        expect(duplicate_user.errors[:email]).to include("has already been taken")
      end

      it "must NOT be case sensitive for :email property" do
        User.create(first_name: "This", last_name: "Guy", email: "test@test.com", password: "testing")
        case_user = User.new(first_name: "That", last_name: "Person", email: "TEST@test.com", password: "password")
        expect(case_user).to_not be_valid
        expect(case_user.errors[:email]).to include("has already been taken")
      end

    end

    context "testing password validation" do

      it "must be valid if a valid :password is provided (>=6 characters)" do
        user = User.new(first_name: "This", last_name: "Guy", email: "test@test.com", password: "testing")
        expect(user).to be_valid
        expect(user.authenticate("testing")).to be_truthy
      end

      it "must NOT be valid if :password is NOT provided" do
        user = User.new(first_name: "This", last_name: "Guy", email: "test@test.com", password: nil)
        expect(user).to_not be_valid
        expect(user.errors[:password]).to include("can't be blank")
      end

      it "must NOT be valid if :password is < 6 characters long" do
        user = User.new(first_name: "This", last_name: "Guy", email: "test@test.com", password: "short")
        expect(user).to_not be_valid
        expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end

    end

  end

  describe ".authenticate_with_credentials" do

    before(:each) do
      @user = User.create(first_name: "Example", last_name: "User", email: "test@example.com", password: "password123", password_confirmation: "password123")
    end

    context "testing email string sloppy formatting" do

      it "should accept valid emails with leading/trailing ' ' characters" do
        authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password123')
        expect(authenticated_user).to eq(@user)
      end

      it "should accept valid emails regardless of case usage (ie. eXample@domain.COM = EXAMPLe@DOMAIN.CoM)" do
        authenticated_user = User.authenticate_with_credentials('TeSt@ExAmPlE.CoM', 'password123')
        expect(authenticated_user).to eq(@user)
      end
      
    end

  end

end
