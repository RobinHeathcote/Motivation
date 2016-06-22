class Streak < ActiveRecord::Base

  belongs_to :obstacle

  validates :completed, :obstacle_id, presence: true
end
