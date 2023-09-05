# README

# テーブル設計

## users テーブル


| Column             | Type   | Options                       |
| ------------------ | ------ | ----------------------------- |
| nickname           | string | null: false                   |
| email              | string | null: false, unique: true     |
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





## items テーブル


| Column             | Type       | Options                        |
| ------------------ | ---------  | ------------------------------ |
| name               | string     | null: false                    |
| description        | text       | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| shipping_method_id | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| days_to_ship_id    | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |


### Association
# 一つの商品は一つのユーザーに所属する
belongs_to :user
# 一つの商品は一つの発送履歴を持つ
has_one :order
# 複数の商品が一つのカテゴリーに属している
belongs_to :category

//以下は補足
//belongs_to :condition
//belongs_to :shipping_method
//belongs_to :prefecture
//belongs_to :days_to_ships


## orders テーブル


| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |


### Association
# 購入履歴は一人のユーザーに何個も存在する
belongs_to :user
# 購入履歴は一つの商品につき一つずつ
belongs_to :item
# 購入履歴は一つの発送先を持つ
has_one :address



## addresses テーブル


| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | string     | null: false,                   |
| prefecture      | integer    | null: false,                   |
| city            | string     | null: false,                   |
| street_address  | string     | null: false,                   |
| building_name   | string     |                                |
| phone_number    | string     | null: false,                   |
| order           | references | null: false, foreign_key: true |


### Association
# 発送先情報は一つの購入履歴に対して一つ
belongs_to :order