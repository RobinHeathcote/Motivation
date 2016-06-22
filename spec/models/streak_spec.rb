require 'rails_helper'

RSpec.describe Streak, type: :model do

  it { should belong_to(:obstacle) }

end
