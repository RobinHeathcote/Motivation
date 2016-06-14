class Wish < ActiveRecord::Base

  belongs_to :user

  validates :wish_text, :outcome_text, :user_id, presence: true
end
