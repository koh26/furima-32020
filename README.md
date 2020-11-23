## usersテーブル

| Column              | Type      | Options     |
| ------------------- | --------- | ----------- |
| nickname            | string    | null: false |
| email               | string    | null: false |
| encrypted_password  | string    | null: false |
| last_name           | string    | null: false |
| first_name          | string    | null: false |
| k_last_name         | string    | null: false |
| k_first_name        | string    | null: false |
| birthday            | date      | null: false |

### Association

- has_many :items
- has_many :buyers

## itemsテーブル

| Column         | Type            | Options                        |
| -------------- | --------------- | ------------------------------ |
| title          | string          | null: false                    |
| about          | text            | null: false                    |
| category_id    | integer         | null: false                    |
| status_id      | integer         | null: false                    |
| fee_id         | integer         | null: false                    |
| prefecture_id  | integer         | null: false                    |
| day_id         | integer         | null: false                    |
| price          | integer         | null: false                    |
| user           | references      | null: false, foreign_key: true |

### Association

- belongs_to : user
- has_one :buyer

## buyersテーブル

| Column  | Type        | Options                         |
| ------- | ----------- | ------------------------------- |
| user    | references  | null: false, foreign_key: true  |
| item    | references  | null: false, foreign_key: true  |

### Association

- belongs _to :item
- belongs_to :user
- has_one :address

## addressテーブル

| Column          | Type        | Options                         |
| --------------- | ----------- | ------------------------------- |
| postal_code     | string      | null: false                     |
| prefecture_id   | integer     | null: false                     |
| city            | string      | null: false                     |
| number          | string      | null: false                     |
| building        | string      |                                 |
| tel             | string      | null: false                     |
| buyer           | references  | null: false, foreign_key: true  |

### Association

- belongs_to :buyer
