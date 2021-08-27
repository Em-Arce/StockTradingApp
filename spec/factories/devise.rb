FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    admin { false }
    broker { true }
    buyer { true }
    password { Faker::Internet.password }
  end

  factory :admin, class:"User" do
    email {"test@admin.com"}
    admin {true}
    broker { true }
    buyer { true }
    password {"qwerty1207"}
  end

  #test status
  factory :broker do
    email { Faker::Internet.email }
    admin { false }
    broker { true }
    buyer { false }
    password { Faker::Internet.password }
  end

  factory :buyer do
    email { Faker::Internet.email }
    admin { false }
    broker { false }
    buyer { true }
    password { Faker::Internet.password }
  end
end
