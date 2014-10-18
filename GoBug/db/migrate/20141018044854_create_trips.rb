class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.references :user, index: true, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.integer :budget, null: false
      t.boolean :is_published, default: false
      t.boolean :is_private, default: false

      t.timestamps
    end
  end
end
