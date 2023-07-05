class User < ApplicationRecord
    has_many :categories, foreign_key: :user_id, dependent: :delete_all
    has_many :transactions, foreign_key: :user_id, dependent: :delete_all
end
