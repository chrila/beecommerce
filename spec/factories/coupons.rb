FactoryBot.define do
  factory :coupon do
    value { "9.99" }
    percent { false }
    code { "MyString" }
  end
end
