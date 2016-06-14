require 'rails_helper'

RSpec.describe Wish, type: :model do

  it { should respond_to(:wish_text) }
  it { should respond_to(:outcome_text) }
  it { should belong_to(:user)}
  it { should validate_presence_of(:wish_text) }
  it { should validate_presence_of(:outcome_text) }
end
