# spec/factories/roominfos.rb

FactoryBot.define do
  factory :room do |f|
    f.name "Factory1"
    f.password "abcdefgh"
    f.roomcode "wxyz"
  end
end