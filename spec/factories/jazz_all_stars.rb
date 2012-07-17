FactoryGirl.define do
  factory :jazz_all_stars, :class => Team do
    name "Jazz All-Stars"
    players do |player|
      [player.association(:coltrane), player.association(:miles), player.association(:louis)]
    end
  end
  factory :default_player, :class => Player do
    skill_level { rand(10) }
  end
  factory :coltrane, :parent => :default_player do
    name "John Coltrane"
  end
  factory :miles, :parent => :default_player do
    name "Miles Davis"
  end
  factory :louis, :parent => :default_player do
    name "Louis Armstrong"
  end
end
