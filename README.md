# README

# テーブル設計

## users テーブル


| Column             | Type   | Options                       |
| ------------------ | ------ | ----------------------------- |
| nickname           | string | null: false                   |
| email              | string | null: false, uniqueness: true |
| encrypted_password | string | null: false                   |
| family_name        | string | null: false                   |
| last_name          | string | null: false                   |
| family_name_kana   | string | null: false                   |
| first_name_kana    | string | null: false                   |
| birthday           | date   | null: false                   |


### Association
# 一人のユーザーは複数の商品を出品できる
has_many :items
# 一人のユーザーは複数の購入履歴を持つ
has_many :orders
# 一つのユーザーは複数の発送先情報を持つ
has_many :address




## items テーブル


| Column            | Type       | Options                        |
| ----------------- | ---------  | ------------------------------ |
| name              | string     | null: false                    |
| description       | text       | null: false                    |
| category          | string     | null: false                    |
| condition         | string     | null: false                    |
| shipping_method   | string     | null: false                    |
| origin_prefecture | string     | null: false                    |
| days_to_ship      | string     | null: false                    |
| price             | integer    | null: false                    |
| user_id           | references | null: false, foreign_key: true |


### Association
# 一つの商品は一つのユーザーに所属する
belongs_to :user
# 一つの商品は一つの発送履歴を持つ
has_one :order



## orders テーブル


| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| sold    | boolean    | default: false, null: false    |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |


### Association
# 購入履歴は一人のユーザーに何個も存在する
belongs_to :user
# 購入履歴は一つの商品につき一つずつ
belongs_to :item
# 購入履歴は一つの発送先を持つ
has_one :order



## addresses テーブル


| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | string     | null: false,                   |
| prefecture      | string     | null: false,                   |
| city            | string     | null: false,                   |
| street_address  | string     | null: false,                   |
| building_name   | string     | null: false,                   |
| phone_number    | integer    | null: false,                   |
| order_id        | references | null: false, foreign_key: true |
| user_id         | references | null: false, foreign_key: true |


# 発送先情報は一人のユーザーに対して何個もある（届け先が住所だったり会社だったりするため）
belongs_to :user

# 発送先情報は一つの購入履歴に対して一つ
belongs_to :order