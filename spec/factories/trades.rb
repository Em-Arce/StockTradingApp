FactoryBot.define do
  factory :trade do
    stock { nil }
    user { nil }
    quantity { "" }
    purchase_price { "9.99" }
  end
end
