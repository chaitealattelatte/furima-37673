## usersテーブル

| Column        | Type   | Options                   |
| ------------- | ------ | ------------------------- |
| nickname      | string | null: false               |
| email         | string | null: false, unique: true |
| password      | string | null: false               |
| family_name   | string | null: false               |
| first_name    | string | null: false               |
| kana_family   | string | null: false               |
| kana_first    | string | null: false               |
| date_of_birth | string | null: false               |

### Association
- has_many :items
- has_many :orders

## itemsテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| item          | string     | null: false                    |
| description   | text       | null: false                    |
| category      | string     | null: false                    |
| condition     | string     | null: false                    |
| charge        | string     | null: false                    |
| source        | string     | null: false                    |
| delivery_days | string     | null: false                    |
| price         | string     | null: false                    |
| user          | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchaser
- has_one :order

## purchasersテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| post_code   | string     | null: false                    |
| prefectures | string     | null: false                    |
| city        | string     | null: false                    |
| address     | string     | null: false                    |
| building    | string     | null: false                    |
| phone       | string     | null: false                    |
| item        | references | null: false, foreign_key: true |

### Association
- has_one :item
- has_one :order

## ordersテーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| purchaser | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |


### Association
- has_one :purchaser
- has_one :item
- belongs_to :user
