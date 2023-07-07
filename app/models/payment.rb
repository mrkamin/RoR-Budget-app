class Payment < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_and_belongs_to_many :categories

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :user_id, presence: true
  validates :categories, presence: true, length: { minimum: 1 }
end
