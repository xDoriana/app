class CreateBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :budgets do |t|
      t.integer :hours
      t.date :start_date
      t.date :end_date
      t.references :employer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
