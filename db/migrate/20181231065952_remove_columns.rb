class RemoveColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :order_items, :card_id, :integer
  end
end
