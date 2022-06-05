## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| family_name        | string | null: false               |
| first_name         | string | null: false               |
| kana_family        | string | null: false               |
| kana_first         | string | null: false               |
| date_of_birth      | date   | null: false               |

### Association
- has_many :items
- has_many :orders

## itemsテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| description     | text       | null: false                    |
| category_id     | integer    | null: false                    |
| condition_id    | integer    | null: false                    |
| charge_id       | integer    | null: false                    |
| source_id       | integer    | null: false                    |
| delivery_day_id | integer    | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order

## purchasersテーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| post_code | string     | null: false                    |
| source_id | integer    | null: false                    |
| city      | string     | null: false                    |
| address   | string     | null: false                    |
| building  | string     |                                |
| phone     | string     | null: false                    |
| order     | references | null: false, foreign_key: true |

### Association
- belongs_to :order

## ordersテーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| item      | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

### Association
- has_one :purchaser
- belongs_to :item
- belongs_to :user
