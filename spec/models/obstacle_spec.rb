require 'rails_helper'

describe Obstacle do

  before { @obstacle = FactoryGirl.build(:obstacle)}

  subject { @obstacle }

  it { should respond_to(:obstacle_text) }
  it { should respond_to(:plan_text) }
  it { should be_valid }
  it { should validate_presence_of(:obstacle_text) }
  it { should validate_presence_of(:plan_text) }
  it { should belong_to(:wish) }
  it { should have_many(:streaks)}
end
