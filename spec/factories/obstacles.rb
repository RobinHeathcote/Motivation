FactoryGirl.define do
  factory :obstacle do
    wish_id 1
    obstacle_text {FFaker::Lorem.phrase}
    plan_text {FFaker::Lorem.phrase}
  end
end
