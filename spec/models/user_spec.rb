require 'rails_helper'

describe User do

  before { @user = FactoryGirl.build(:user)}

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation)}
  it { should be_valid }
end

describe "when email is not present" do
  before { @user.email = "" }
  it {should_not_be_valid}
end
