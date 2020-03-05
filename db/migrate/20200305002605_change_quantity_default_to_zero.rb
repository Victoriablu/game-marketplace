class ChangeQuantityDefaultToZero < ActiveRecord::Migration[6.0]
  def change
    change_column_default :line_items, :quantity, 0
  end
end
