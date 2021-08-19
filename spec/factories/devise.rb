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
end
