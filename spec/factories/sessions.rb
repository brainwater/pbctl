# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :session do
    remember_token "MyString"
    user_id 1
  end
end
