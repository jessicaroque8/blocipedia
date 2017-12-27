FactoryBot.define do
   factory :wiki do
     title 'My wiki title'
     body 'This is my wiki body and it passes all the validation tests. 12345! '
     user
   end
 end
