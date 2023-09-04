class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :user null: false, foreign_key: true
      t.string :type
      t.string :status
      t.float :amount
      t.timestamps
    end
  end

end
