class AddInvoiceToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :line_items, :invoice_id, :integer
  end
end
