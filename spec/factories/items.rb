FactoryBot.define do
  factory :item do
    title                 { 'テスト' }
    # image                 {'ActionDispatch::Http::UploadedFile:0x00007ff9b2bbd2e0 @tempfile=#<Tempfile:/var/folders/h3/9v6_xygx5yn97pg39wgf7hpw0000gn/T/RackMultipart20201123-6970-8kvshs.jpg'}
    about                 { 'テストの説明' }
    category_id           { '2' }
    status_id             { '2' }
    fee_id                { '2' }
    prefecture_id         { '2' }
    day_id                { '2' }
    price                 { '3000' }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
