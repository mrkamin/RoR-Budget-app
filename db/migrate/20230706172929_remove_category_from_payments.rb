class RemoveCategoryFromPayments < ActiveRecord::Migration[7.0]
  def change
    remove_reference :payments, :category, null: false, foreign_key: true
  end
end