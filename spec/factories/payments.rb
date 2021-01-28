FactoryBot.define do
  factory :payment do
    order { nil }
    payment_method { nil }
    name { "MyString" }
    total { "9.99" }
    token { "MyString" }
  end
end
