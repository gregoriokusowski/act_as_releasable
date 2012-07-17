FactoryGirl.define do
  factory :phantoms, :class => Team do
    name "Phantoms"
  end
  factory :gasper, :class => Player do
    name "Gasper"
    skill_level { rand(10) }
  end
end
