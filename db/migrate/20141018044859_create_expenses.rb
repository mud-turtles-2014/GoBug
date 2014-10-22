class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.references :location, index: true, null: false
      t.float :cost
      t.string :title#, null: false
      t.text :description#, null: false
      t.references :category, index: true, null: false
      t.date :date
      t.references :trip, index: true, null: false
      t.references :currency
      t.float :usd_cost

      t.timestamps
    end
  end
end
