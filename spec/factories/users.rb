FactoryBot.define do
   pw = 'abc12345'

   factory :user do
     sequence(:email){|n| "user#{n}@factory.com" }
     password pw
     password_confirmation pw
   end
 end
