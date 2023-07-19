# README

# テーブル設計

## users テーブル


| Column             | Type              | Options                       |
| ------------------ | ----------------- | ----------------------------- |
| nickname           | string            | null: false                   |
| email              | string            | null: false, uniqueness: true |
| password_digest    | string:bcrypt     | null: false                   |
| family_name        | string            | null: false                   |
| last_name          | string            | null: false                   |
| family_name_kana   | string            | null: false                   |
| first_name_kana    | string            | null: false                   |
| birthday           | date              | null: false                   |


### Association
# 一つのユーザーは複数の商品を出品できる
has_many :items
# 一つのユーザーは何度もコメントを投稿できる
has_many :comments


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
# 一つの商品は複数のコメントを持つ
has_many :comments


## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| content   | text       | null: false                    |
| user_id   | references | null: false, foreign_key: true |
| item_id   | references | null: false, foreign_key: true |

### Association
# 一つのコメントは一つのユーザーに所属する
belongs_to :user
# 一つのコメントは一つの商品に所属する
belongs_to :item