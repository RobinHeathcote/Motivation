class Streak < ActiveRecord::Base

  belongs_to :obstacle

  validates :obstacle_id, presence: true
end
