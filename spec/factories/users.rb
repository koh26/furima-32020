FactoryBot.define do
  factory :user do
    nickname              { 'たろう' }
    email                 { Faker::Internet.free_email }
    password              { 'a11111' }
    password_confirmation { password }
    last_name             { '太郎' }
    first_name            { '山田' }
    k_last_name           { 'タロウ' }
    k_first_name          { 'ヤマダ' }
    birthday              { '1993-12-6' }
  end
end
