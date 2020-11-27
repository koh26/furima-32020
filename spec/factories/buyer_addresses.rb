FactoryBot.define do
  factory :buyer_address do
  postal_code          { '123-4567' }
  prefecture_id        { 2 }
  city                 { '東京都' }
  number               { '1-1' }
  building             { '東京ハイツ' }
  tel                  { '09078550814' }
  end
end

