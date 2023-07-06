class Category < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_and_belongs_to_many :category_transactions

  def total_category_amount
      payments.where(user_id:).sum(:amount)
    end
  
    validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
    validates :user_id, presence: true
    validates :icon, presence: true
end