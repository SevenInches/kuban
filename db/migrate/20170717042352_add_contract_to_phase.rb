class AddContractToPhase < ActiveRecord::Migration[5.0]
  def change
    add_column :renting_phases, :contract_id, :integer
  end
end
