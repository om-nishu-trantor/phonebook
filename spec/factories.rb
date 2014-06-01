FactoryGirl.define do
  sequence :phone do |n|
    "895654#{n}"
  end
  factory :phone_list do
    phone
    name ['Camilo', 'Amanda', 'Luka', 'Dirk Van'].sample
  end
end
