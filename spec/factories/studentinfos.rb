# spec/factories/studentinfos.rb

FactoryBot.define do
  factory :student_info do |f|
    f.name "aaaa"  #this must be 4 chars to pass validation
    f.roomcode "cccc"
  end
end