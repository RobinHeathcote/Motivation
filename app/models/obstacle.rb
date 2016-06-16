class Obstacle < ActiveRecord::Base

  belongs_to :wish
  validates :obstacle_text, :plan_text, :wish_id, presence: true

end
