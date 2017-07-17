class AddContractToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :contract_id, :integer
  end
end
