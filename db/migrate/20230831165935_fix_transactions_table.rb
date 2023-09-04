class FixTransactionsTable < ActiveRecord::Migration[7.0]
    def change
      rename_column :transactions, :type, :tx_type
      add_column :transactions, :to_user, :integer
    end
end
